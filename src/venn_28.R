# Title     : TODO
# Objective : TODO
# Created by: JiaweiMao
# Created on: 6/19/2020

venn.plot <- venn.diagram(
  x = list(
    A = 1:80,
    B = 41:150,
    C = 71:100
  ),
  filename = "2-8_triple_special_case-011A.tiff",
  cex = 2.5,
  cat.cex = 2.5,
  cat.dist = c(0.07, 0.07, 0.02),
  cat.pos = c(-20, 20, 20)
)