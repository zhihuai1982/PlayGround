library("Hmisc")
library("corrplot")
fer <- read.csv("./TilePlot.csv", header = TRUE)
fer.cor <- cor(fer,
  method = c("spearman")
)
fer.rcorr <- rcorr(as.matrix(fer))

##  different color series
col5 <- colorRampPalette(c("#053061", "#2166AC", "#4393C3", "#92C5DE", "#D1E5F0", "#FFFFFF", "#FDDBC7", "#F4A582", "#D6604D", "#B2182B", "#67001F"))
corrplot(fer.cor,
  col = col5(200),
)
