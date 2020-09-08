library(tidyverse)
library(socviz)

df1 <- gss_sm %>%
  select(bigregion) %>%
  count(bigregion) %>%
  mutate(ratio = n / sum(n))

p <- ggplot(
  data = df1,
  mapping = aes(x = bigregion, y = n)
)
gp <- p + geom_col() +
  labs(y = "Count")
print(gp)

p <- ggplot(
  data = df1,
  mapping = aes(x = bigregion, y = ratio)
)
print(p + geom_col() + labs(y = "Ratio"))
