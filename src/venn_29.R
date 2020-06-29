# Title     : TODO
# Objective : TODO
# Created by: JiaweiMao
# Created on: 6/19/2020

venn.plot <- venn.diagram(
  x = list(
    A = 1:10,
    B = 11:90,
    C = 81:90
  ),
  filename = "2-9_triple_special_case-121AO.tiff",
  cex = 2.5,
  cat.cex = 2.5,
  cat.pos = 0,
  cat.dist = c(0.04, 0.04, 0.02),
  reverse = FALSE
)