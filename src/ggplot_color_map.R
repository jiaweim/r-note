library(readr)
library(ggplot2)

d1 <- read_table2("cond yval
    A 2
    B 2.5
    C 1.6")
d2 <- read_table2("cond1 cond2 yval
    A      I 2
    A      J 2.5
    A      K 1.6
    B      I 2.2
    B      J 2.4
    B      K 1.2
    C      I 1.7
    C      J 2.3
    C      K 1.9")

ggplot(d1, aes(x = cond, y = yval, fill = cond)) +
  geom_bar(stat = "identity")

ggplot(d2, aes(x = cond1, y = yval)) +
  geom_bar(aes(fill = cond2),
    stat = "identity",
    color = "black",
    position = position_dodge()
  )


