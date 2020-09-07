library(ggplot2)

bp <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot()
bp + scale_x_discrete(limits = c("trt1", "trt2", "ctrl"))
print(bp)