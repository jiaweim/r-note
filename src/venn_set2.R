# Title     : TODO
# Objective : TODO
# Created by: JiaweiMao
# Created on: 6/19/2020

library(VennDiagram)

venn.plot <- venn.diagram(
  x = list(
    "A" = 1:100,
    "B" = 96:140
  ),
  filename = "Venn_2set_complex.tiff",
  scaled = TRUE,
  ext.text = TRUE,
  ext.line.lwd = 2,
  ext.dist = -0.15,
  ext.length = 0.9,
  ext.pos = -4,
  inverted = TRUE,
  cex = 2.5,
  cat.cex = 2.5,
  rotation.degree = 45,
  main = "Complex Venn Diagram",
  sub = "Featuring: rotation and external lines",
  main.cex = 2,
  sub.cex = 1
)