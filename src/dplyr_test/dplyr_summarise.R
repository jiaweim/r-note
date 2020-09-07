library(tidyverse)

d.cancer <- read_csv("../data/cancer.csv",
                     locale = locale(encoding = "GBK")
)

knitr::kable(d.cancer)

d.cancer %>%
  summarise(
    nobs = n(),
    n = sum(!is.na(age)),
    mean.age = mean(age, na.rm = TRUE),
    sd.age = sd(age, na.rm = TRUE)
  ) %>%
  knitr::kable()
