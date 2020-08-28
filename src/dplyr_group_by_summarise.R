library(tidyverse)

d.cancer <- read_csv("src/data/cancer.csv")
d.cancer %>%
  group_by(sex) %>%
  summarise(
    nold = sum(age >= 60, na.rm = TRUE),
    pold = nold / n()
  ) %>%
  knitr::kable()
