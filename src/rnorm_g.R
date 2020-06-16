library(tidyverse)

p <- tibble(
  x = rnorm(n = 100, mean = 0, sd = 1)
) %>% ggplot(aes(x = x)) +
  geom_density() +
  stat_function(
    fun = dnorm,
    args = list(mean = 0, sd = 1),
    color = "red"
  )
print(p)
