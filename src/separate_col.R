library(tidyverse)

d.sep <- read_csv(
  "testid, succ/total
1, 1/10
2, 3/5
3, 2/8
")

knitr::kable(d.sep)

d.sep %>% 
  separate("succ/total", into = c("succ", "total"),
           sep = "/", convert = TRUE) %>% knitr::kable()
