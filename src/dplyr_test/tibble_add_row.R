library(tidyverse)


df <- tibble(x = 0, y = 1)

for (x in 1:10) {
  df <- df %>% add_row(x = x * 2, y = x^2)
}

print(df)