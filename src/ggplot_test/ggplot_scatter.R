library(tidyverse)
library(gapminder)

p <- ggplot(
  data = gapminder,
  mapping = aes(
    x = gdpPercap,
    y = lifeExp,
    color = continent,
    fill = continent
  )
)

p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10(labels = scales::dollar)
