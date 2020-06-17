library(ggplot2)
library(dplyr)
library(gcookbook)

myfun <- function(xvar) {
  1 / (1 + exp(-xvar + 10))
}

p <- ggplot(
  data.frame(x = c(0, 20)),
  aes(x = x)
) +
  stat_function(fun = myfun, geom = "line")
print(p)
