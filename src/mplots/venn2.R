# Title     : draw venn of custom settings
# Objective : TODO
# Created by: JiaweiMao
# Created on: 6/23/2020

#library(VennDiagram)

library(eulerr)
plot(euler(c("SEQUEST" = 2515, "IGD-O" = 32821, "SEQUEST&IGD-O" = 32463)),
     quantities = TRUE,
     fills = c("#636EFA", "#EF553B", "#00CC96"),
     shape = 'ellipse'
)

#draw.pairwise.venn(area1 = 34978, area2 = 65284, cross.area = 32463,
#                   col = c("white", "white"),
#                   cex = c(2, 2, 2),
#                   fontfamily = "Arial",
#                   fill = c("#636EFA", "#EF553B"),
#                   lwd = c(2, 2)
#)
#
