library(tidyverse)
library(socviz)

df2 <- gss_sm %>%
  select(religion) %>%
  count(religion)

p <- ggplot(
  data = df2,
  mapping = aes(
    x = religion,
    y = n,
    fill = religion
  )
)

print(p + geom_col() + labs(y = "Count"))
