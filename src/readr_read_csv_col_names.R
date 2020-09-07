library(readr)

d.small <- read_csv("John, 33, 95
Kim, 21, 64
Sandy, 49, 100", col_names = c("name", "x", "y"))
print(d.small)