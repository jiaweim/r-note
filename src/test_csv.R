f <- function(x) {
  y <- numeric(length(x))
  y[x >= 0] <- 1
  y[x < 0] <- 0
}

