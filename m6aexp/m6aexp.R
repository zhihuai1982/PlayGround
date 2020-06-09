library(data.table)
library(ggpubr)
setwd("./")

rt <- read.table(
  "m6Aexp.txt",
  sep = "\t",
  header = T,
  row.names = 1,
  check.names = F
) # 读取输入文件
rt <- t(rt)

m6 <- as.data.table(rt)
m6[, `:=`(tn, c(rep("Normal", 44), rep("Tumor", 502)))][, `:=`(tn, as.factor(tn))]
m6.ml <- melt(m6, id.vars = c("tn"))

# compare_means(value~tn, m6.ml, method = "wilcox.test", group.by = "variable")

m6.ml[, .(wilcox.test(.SD[tn == "Normal"]$value, .SD[tn == "Tumor"]$value)$p.value), by = .(variable)]

p <- ggboxplot(
  m6.ml,
  x = "variable",
  y = "value", color = "tn", palette = "jco", size = 0.3, width = 0.5, outlier.size = 0.5
) + stat_compare_means(
  aes(group = tn),
  label = "p.signif",
  label.y.npc = c(0.12, 0.4, 0.12, 0.7, rep(0.12, 8), 1, rep(0.12, 5)),
  hide.ns = F,
  size = 3
)

ggpar(p,
  main = "The Cancer Geneome Atlas (TCGA)",
  xlab = F,
  ylab = "Relative Expression",
  x.text.angle = 45,
  font.xtickslab = c(8, "plain", "black"),
  font.ytickslab = c(8, "plain", "black"),
  legend = "right",
  legend.title = ""
)
