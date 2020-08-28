library(tidyverse)

d.cancer <- read_csv("src/data/cancer.csv", locale = locale(encoding = "GBK"))
d.cancer %>%
  count(sex, type) %>%
  knitr::kable()
