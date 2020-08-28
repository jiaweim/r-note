library(tidyverse)

d.cancer <- read_csv("src/data/cancer.csv")
d.cancer %>%
  group_by(sex) %>%
  summarise(
    count = n(),
    mean.age = mean(age, na.rm = TRUE)
  ) %>%
  knitr::kable()
