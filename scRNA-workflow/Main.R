# BiocManager::install("BiocFileCache")
library(BiocFileCache)
# browseVignettes('BiocFileCache') 查看帮助文档
# 首先自定义一个存放数据的目录
bfc <- BiocFileCache("raw_data", ask = FALSE)
# file.path可以是本地路径或者网络链接（直接下载到BiocFileCache指定的目录）
lun.zip <- bfcrpath(
    bfc,
    file.path(
        "https://www.ebi.ac.uk/arrayexpress/files",
        "E-MTAB-5522/E-MTAB-5522.processed.1.zip"
    )
)
lun.sdrf <- bfcrpath(
    bfc,
    file.path(
        "https://www.ebi.ac.uk/arrayexpress/files",
        "E-MTAB-5522/E-MTAB-5522.sdrf.txt"
    )
)
unzip(lun.zip, exdir = tempdir())


plate1 <- read.delim(file.path(tempdir(), "counts_Calero_20160113.tsv"),
    header = TRUE, row.names = 1, check.names = FALSE
)

plate1[1:4, 1:5]
# Length SLX-9555.N701_S502.C89V9ANXX.s_1.r_1
# ENSMUSG00000102693   1070                                    0
# ENSMUSG00000064842    110                                    0

dim(plate1)
# [1] 46703    97

plate2 <- read.delim(file.path(tempdir(), "counts_Calero_20160325.tsv"),
    header = TRUE, row.names = 1, check.names = FALSE
)

dim(plate2)

gene.lengths <- plate1$Length # 提取基因长度
plate2 <- as.matrix(plate2[, -1])

stopifnot(identical(rownames(plate1), rownames(plate2)))
all.counts <- cbind(plate1, plate2)


suppressMessages(library(SingleCellExperiment))
sce <- SingleCellExperiment(list(counts = all.counts))
# 将基因长度信息添加在rowData中作为注释
rowData(sce)$GeneLength <- gene.lengths

isSpike(sce, "ERCC") <- grepl("^ERCC", rownames(sce))
summary(isSpike(sce, "ERCC"))

is.sirv <- grepl("^SIRV", rownames(sce))
summary(is.sirv)
##    Mode   FALSE    TRUE
## logical   46696       7
sce <- sce[!is.sirv, ]

# 依旧使用check.names读入细胞注释信息
metadata <- read.delim(lun.sdrf, check.names = FALSE, header = TRUE)
metadata[1:3, 1:3]
# match的作用是返回前一个参数在后一个参数中的位置
m <- match(colnames(sce), metadata[["Source Name"]])
# 这样m就存储了一系列的位置，将表达矩阵的列和细胞注释信息的行顺序一一对应起来

stopifnot(all(!is.na(m))) # 检查是否完整（即包含所有的细胞）
metadata <- metadata[m, ]
# 这样就保证了我们只取到和表达矩阵相关的细胞注释，其他无用信息可以去除
head(colnames(metadata))

# 先添加细胞来源
colData(sce)$Plate <- factor(metadata[["Factor Value[block]"]])
# 然后添加细胞表型
pheno <- metadata[["Factor Value[phenotype]"]]
levels(pheno) <- c("induced", "control")
colData(sce)$Oncogene <- pheno
# 最后看看新增的细胞表型数据
table(colData(sce)$Oncogene, colData(sce)$Plate)

# BiocManager::install("org.Mm.eg.db")
library(org.Mm.eg.db)
symb <- mapIds(org.Mm.eg.db, keys = rownames(sce), keytype = "ensembl", column = "symbol")

# 看看数据类型
head(symb)
# 检测一下它们的Ensembl ID是否一样
identical(names(symb), rownames(sce))
rowData(sce)$SYMBOL <- symb
rowData(sce)$ENSEMBL <- rownames(sce)

head(rowData(sce))

library(scater)
# 参数很简单，第一个是ID，第二是names
rownames(sce) <- uniquifyFeatureNames(rowData(sce)$ENSEMBL, rowData(sce)$SYMBOL)

head(rownames(sce))

# BiocManager::install('TxDb.Mmusculus.UCSC.mm10.ensGene')
library(TxDb.Mmusculus.UCSC.mm10.ensGene)
# TxDb storing transcript annotations（包括CDS、Exon、Transcript的start、end、chr-location、strand）
columns(TxDb.Mmusculus.UCSC.mm10.ensGene)
# 返回一个GRanges对象
head(transcripts(TxDb.Mmusculus.UCSC.mm10.ensGene, columns = c("CDSCHROM")))
# 补充：如果是想看org.db其中的内容
if (F) {
    keytypes(org.Hs.eg.db)
    head(mappedkeys(org.Hs.egENSEMBL))
}

location <- mapIds(TxDb.Mmusculus.UCSC.mm10.ensGene,
    keys = rowData(sce)$ENSEMBL,
    column = "CDSCHROM", keytype = "GENEID"
)
rowData(sce)$CHR <- location
summary(location == "chrM")

mito <- which(rowData(sce)$CHR == "chrM")

sce <- calculateQCMetrics(sce, feature_controls = list(Mt = mito))
head(colnames(colData(sce)), 10)

sce$PlateOnco <- paste0(sce$Oncogene, ".", sce$Plate)
multiplot(
    plotColData(sce, y = "total_counts", x = "PlateOnco"),
    plotColData(sce, y = "total_features_by_counts", x = "PlateOnco"),
    plotColData(sce, y = "pct_counts_ERCC", x = "PlateOnco"),
    plotColData(sce, y = "pct_counts_Mt", x = "PlateOnco"),
    cols = 2
)
