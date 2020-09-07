library(tidyverse)

d.cancer <- read_csv("../data/cancer.csv")
bind_cols(
  d.cancer %>%
    group_by(sex) %>%
    summarise(count = n()),
  d.cancer %>%
    group_by(sex) %>%
    summarise_at(
      c("v0", "v1"),
      list(avg = ~ mean(.), std = ~ sd(.)),
      na.rm = TRUE
    ) %>%
    select(-sex)
)
