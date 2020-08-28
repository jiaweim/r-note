library(tidyverse)

d.cancer <- read_csv("src/data/cancer.csv",
  locale = locale(encoding = "GBK")
)

d.cancer %>%
  summarise(
    mean.v0 = mean(v0, na.rm = TRUE),
    sd.v0 = sd(v0, na.rm = TRUE),
    mean.v1 = mean(v1, na.rm = TRUE),
    sd.v1 = sd(v1, na.rm = TRUE),
  ) %>%
  knitr::kable()
