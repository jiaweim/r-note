# Title     : TODO
# Objective : TODO
# Created by: JiaweiMao
# Created on: 6/19/2020

library(VennDiagram)

venn.plot <- venn.diagram(
  list(A = 1:150, B = 121:170, C = 101:200),
  "Venn_3Set_simple.tiff"
)