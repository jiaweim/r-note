# Title     : TODO
# Objective : TODO
# Created by: JiaweiMao
# Created on: 6/23/2020

library(eulerr)
plot(euler(c("A" = 5, "B" = 4, "A&B" = 2)), quantities = TRUE, fills = c("white", "white", "red"))

f <- function(x) {
  y <- numeric(length(x))
  y[x >= 0] <- 1
  y[x < 0] <- 0 # <U+591A><U+4F59>

  y
}
