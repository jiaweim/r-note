library(tidyverse)

dwide <- read_csv(
  "subject,1,2,3,4
1,1,NA,NA,NA
2,NA,7,NA,4
3,5,10,NA,NA
4,NA,NA,9,NA"
)
knitr::kable(dwide)

dwide %>% 
  pivot_longer(`1`:`4`,
               names_to="time",
               values_to="response") %>% 
  knitr::kable()

dwide %>% 
  pivot_longer(`1`:`4`,
               names_to="time",
               values_to="response",
               values_drop_na=TRUE) %>% 
  knitr::kable()