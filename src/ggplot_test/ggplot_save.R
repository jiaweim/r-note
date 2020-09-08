library(tidyverse)
library(gapminder)

p <- ggplot(
  data = filter(gapminder, year == 2007),
  mapping = aes(
    x = gdpPercap,
    y = lifeExp,
    color = log(pop)
  )
)

pp <- p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10(labels = scales::dollar)

ggsave(filename = "scatter.png")
