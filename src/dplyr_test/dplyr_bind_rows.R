library(tidyverse)

d.class <- read_csv("../data/class.csv")
knitr::kable(d.class)

d3.class <- d.class %>% 
  select(name, sex, age) %>% 
  filter(sex=="M")
d4.class <- d.class %>% 
  select(name, sex, age) %>% 
  filter(sex=="F")

# 合并
d3.class %>% 
  bind_rows(d4.class) %>% 
  knitr::kable()