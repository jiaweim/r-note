library(tidyverse)
library(NHANES)

NHANES %>%
  count(ID, SurveyYr) %>%
  filter(n >= 2) %>%
  arrange(desc(n)) %>%
  head(10) %>%
  knitr::kable()
