library(gapminder)
library(tidyverse)

p <- ggplot(
  data = gapminder,
  mapping = aes(
    x = year,
    y = lifeExp,
    group = country
  )
)

gp <- p + geom_line() + facet_wrap(~continent)
print(gp)
