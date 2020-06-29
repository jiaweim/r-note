library(VennDiagram)

# Generate 3 sets of 200 words
set1 <- paste0(rep("word_", 200), sample(1:1000, 200, replace = F))
set2 <- paste0(rep("word_", 200), sample(1:1000, 200, replace = F))
set3 <- paste0(rep("word_", 200), sample(1:1000, 200, replace = F))

# Prepare a palette of 3 colors with R colorbrewer:
library(RColorBrewer)
myCol <- brewer.pal(3, "Pastel2")

# Chart
venn.diagram(
  x = list(set1, set2, set3),
  category.names = c("Set 1", "Set 2 ", "Set 3"),
  filename = '#14_venn_diagramm.png',
  output = TRUE,

  # Output features
  imagetype = "png",
  height = 480,
  width = 480,
  resolution = 300,
  compression = "lzw",

  # Circles
  lwd = 2,
  lty = 'blank',
  fill = myCol,

  # Numbers
  cex = .6,
  fontface = "bold",
  fontfamily = "sans",

  # Set names
  cat.cex = 0.6,
  cat.fontface = "bold",
  cat.default.pos = "outer",
  cat.pos = c(-27, 27, 135),
  cat.dist = c(0.055, 0.055, 0.085),
  cat.fontfamily = "sans",
  rotation = 1
)