x <- c(5, 12, 13, 12)
xf <- factor(x)
xff <- factor(x, levels = c(5, 12, 13, 88))

ages <- c(25, 26, 55, 37, 21, 42)
affils <- c("R", "D", "D", "R", "U", "D")
tapply(ages, affils, mean)
