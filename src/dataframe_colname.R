d <- data.frame(
  name = c("Lili", "Lucy", "Dog"),
  age = c(30, 35, 40),
  height = c(180, 175, 160),
  gender = c('F', "F", "M"),
  stringsAsFactors = FALSE
)
print(knitr::kable(d))
names(d) <- c("name_a", "age_a", "height_a", "gender_a")
print(knitr::kable(d))
