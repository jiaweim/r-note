library(tidyverse)
library(gapminder)

p <- ggplot(
  data = gapminder,
  mapping = aes(
    x = gdpPercap,
    y = lifeExp
  )
)

pp <- p + geom_point(color = "chartreuse4") +
  geom_smooth(method = "loess") +
  scale_x_log10(labels = scales::dollar)
print(pp)
