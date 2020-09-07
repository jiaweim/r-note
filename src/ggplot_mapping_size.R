library(ggplot2)

ggplot(mpg, aes(x = displ, y = hwy, size = class)) +
  geom_point()