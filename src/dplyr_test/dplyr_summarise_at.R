library(tidyverse)

d.cancer <- read_csv("../data/cancer.csv")
d.cancer %>%
  summarise_at(
    c("v0", "v1"),
    list(avg = ~ mean(.), std = ~ sd(.)),
    na.rm = TRUE
  ) %>%
  knitr::kable()

d.cancer %>% 
  summarise_at(
    5:6,
    list(avg = ~ mean(.), std = ~ sd(.)),
    na.rm=TRUE
  ) %>% 
  knitr::kable()

d.cancer %>% 
  summarise_at(
    vars(v0, v1),
    list(avg = ~ mean(.), std = ~ sd(.)),
    na.rm=TRUE
  ) %>% 
  knitr::kable()