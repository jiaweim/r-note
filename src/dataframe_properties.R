d <- data.frame(
  name = c("Lili", "Lucy", "Dog"),
  age = c(30, 35, 40),
  height = c(180, 175, 160),
  gender = c('F', "F", "M"),
  stringsAsFactors = FALSE
)
print(nrow(d))
print(ncol(d))
print(length(d))
print(names(d))