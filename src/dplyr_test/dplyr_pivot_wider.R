library(tidyverse)

dbpa <- read_csv(
  "var,avg
  male:systolicbp,118
  male:diastolicbp,85
  female:systolicbp,115
  female:diastolicbp,83"
)
knitr::kable(dbpa)

dbpa2 <- dbpa %>% 
  separate(var, into = c("sex", "var"), sep = ":")
knitr::kable(dbpa2)

dbpa3 <- dbpa2 %>% 
  pivot_wider(names_from = "var", values_from="avg")
knitr::kable(dbpa3)