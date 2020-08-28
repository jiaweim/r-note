library(tidyverse)
library(gapminder)

p <- ggplot(
  data = filter(gapminder, country == "Rwanda"),
  mapping = aes(
    x = year,
    y = lifeExp
  )
)
gp <- p + geom_area(fill = "darkseagreen1", alpha = 0.5)

print(gp)
