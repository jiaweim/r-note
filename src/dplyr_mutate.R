library(tidyverse)

d.class <- read_csv("src/data/class.csv")
print(knitr::kable(d.class))

d2 <- d.class %>% 
  mutate(
    rwh=weight/height,
    sexc=ifelse(sex=='F', "女", "男")
  ) %>% 
  head(n=3)
print(knitr::kable(d2))