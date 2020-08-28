library(tidyverse)
library(gapminder)

p <- ggplot(
  data = gapminder,
  mapping = aes(
    x = year,
    y = lifeExp,
    group = country
  )
)
gplot <- p + geom_line()

print(gplot)
