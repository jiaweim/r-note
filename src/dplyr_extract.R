library(tidyverse)

dexp <- tibble(
  design = c("AA", "AB", "BA", "BB"),
  response = c(120, 110, 105, 95)
)
knitr::kable(dexp)

dexp %>% 
  extract(design, 
          into = c("fac1", "fac2"),
          regex = "(.)(.)") %>% 
  knitr::kable()