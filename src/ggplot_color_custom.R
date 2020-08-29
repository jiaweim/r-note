library(readr)
library(ggplot2)

d1 <- read_table2("cond yval
    A 2
    B 2.5
    C 1.6")

ggplot(d1, aes(x = cond, y = yval, fill = cond)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("red", "blue", "green"))

ggplot(d1, aes(x = cond, y = yval, fill = cond)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("#CC6666", "#9999CC", "#66CC99"))