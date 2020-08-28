library(tidyverse)

d.cancer <- read_csv("src/data/cancer.csv")
d.cancer %>%
  group_by(sex) %>%
  summarise_at(
    c("v0", "v1"),
    list(count = ~ n(), avg = ~ mean(.), std = ~ sd(.)),
    na.rm = TRUE
  ) %>%
  knitr::kable()
