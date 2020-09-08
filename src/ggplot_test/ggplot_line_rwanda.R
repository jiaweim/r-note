library(tidyverse)
library(gapminder)

p <- ggplot(
  data = filter(gapminder, country == "Rwanda"),
  mapping = aes(
    x = year,
    y = lifeExp,
    group = country
  )
)
gplot <- p + geom_line() + geom_point()

print(gplot)
