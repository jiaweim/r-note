library(ggplot2)

bp <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot() +
  theme(panel.grid.minor = element_blank())
print(bp)