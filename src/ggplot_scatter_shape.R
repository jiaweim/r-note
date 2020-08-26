library(tidyverse)
library(gapminder)

p <- ggplot(
  data = filter(gapminder, year == 2007),
  mapping = aes(
    x = gdpPercap,
    y = lifeExp,
    shape = continent
  )
)

pp <- p + geom_point(alpha = 0.4, size = 4) +
  geom_smooth(method = "loess") +
  scale_x_log10(labels = scales::dollar)
print(pp)
