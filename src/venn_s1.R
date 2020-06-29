# Title     : TODO
# Objective : TODO
# Created by: JiaweiMao
# Created on: 6/19/2020

library(VennDiagram)

venn.plot <- venn.diagram(
  list(A = 1:150, B = 121:170),
  "Venn_2Set_simple.tiff"
)