library(ggplot2)

ggplot(data = mpg, aes(x = displ, y = hwy, shape = class)) +
  geom_point()