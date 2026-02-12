f <- function() {
  x <- seq(0, 2 * pi, length = 50)
  y1 <- sin(x)
  y2 <- cos(x)
  plot(x, y1, type = 'l', lwd = 2, col = 'red',
       xlab = 'x', ylab = "")
  lines(x, y2, lwd = 2, col = 'blue')
  abline(h = 0, col = 'gray')
}


b <- function (file, pvalue){
  data <- read.csv(file)
  ###


  data
}

data1 <- b("test.csv", 0.02)

a <- function(a, b) {
  a + b
}

x <- 5
y <- 3

z <- a(x, y)
print(z)