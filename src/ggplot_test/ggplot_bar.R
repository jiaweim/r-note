library(tidyverse)
library(socviz)

p <- ggplot(
  data = gss_sm,
  mapping = aes(x = bigregion)
)

gp <- p+geom_bar()
print(gp)
