library(tidyverse)
library(gapminder)

p <- ggplot(
  data = gapminder,
  mapping = aes(
    x = gdpPercap,
    y = lifeExp
  )
)

pp <- p + geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", color = "cadetblue1", se = FALSE, size = 4, alpha = 0.3) +
  scale_x_log10(labels = scales::dollar)
print(pp)
