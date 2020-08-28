library(tidyverse)

d.class <- read_csv("src/data/class.csv")

d.class %>%
  mutate(sexc = {
    x <- rep('男', length(sex))
    x[sex == "F"] <- "女"
    x
  }) %>%
  head(n = 10) %>%
  knitr::kable()
