library(tibble)

tb <- tribble(
  ~"index", ~"count",
  1, 145,
  5, 110,
  6, NA,
  9, 150,
  10, NA,
  15, 115
)
print(tb)