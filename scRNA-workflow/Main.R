BiocManager::install("BiocFileCache")
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
                     header=TRUE, row.names=1, check.names=FALSE)
 
plate1[1:4,1:5]
# Length SLX-9555.N701_S502.C89V9ANXX.s_1.r_1
# ENSMUSG00000102693   1070                                    0
# ENSMUSG00000064842    110                                    0
 
dim(plate1)
# [1] 46703    97
 
plate2 <- read.delim(file.path(tempdir(), "counts_Calero_20160325.tsv"), 
                     header=TRUE, row.names=1, check.names=FALSE)

dim(plate2)
# [1] 46703    97
