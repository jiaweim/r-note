library(tidyverse)
library(gapminder)

d <- gapminder %>%
  filter(country == "Rwanda") %>%
  mutate(year = factor(year, levels = seq(1952, 2007, by = 5)))

p <- ggplot(data = d, mapping = aes(
  x = year,
  y = lifeExp,
  group = country
))
gp <- p + geom_line()
print(gp)
