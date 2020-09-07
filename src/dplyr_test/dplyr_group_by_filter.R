library(tidyverse)

d.cancer <- read_csv("../data/cancer.csv", locale = locale(encoding = "GBK"))
d.cancer %>%
  group_by(sex) %>%
  filter(rank(desc(v0)) <= 2) %>%
  arrange(sex, desc(v0)) %>%
  knitr::kable()
