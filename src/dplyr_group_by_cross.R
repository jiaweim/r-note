library(tidyverse)

d.cancer <- read_csv("src/data/cancer.csv", locale = locale(encoding = "GBK"))
d.cancer %>%
  group_by(sex, type) %>%
  summarise(freq = n()) %>%
  knitr::kable()
