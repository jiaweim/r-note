set.seed(101)
x <- rnorm(5)
y <- numeric(length(x))
for (i in 1:5) {
  if (x[i] >= 0) {
    y[i] <- 1
  } else {
    y[i] <- 0
  }
}
print(y)
