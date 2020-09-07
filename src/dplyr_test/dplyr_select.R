library(tidyverse)

d.class <- read_csv("../data/class.csv")
knitr::kable(d.class)
d.class %>% 
  select(name, age) %>% 
  head(n=3) %>% 
  knitr::kable()

d.class %>% 
  select(age:weight) %>% 
  head(n=3) %>% 
  knitr::kable()

d.class %>%
  select(-name, -age) %>% 
  head(n=3) %>% 
  knitr::kable()

vars <- c("name", "sex")
d.class %>% 
  select(one_of(vars)) %>% 
  head(n=3) %>% 
  knitr::kable()

