library(ggplot2)
library(readr)

d1 <- read_table2("cond yval
    A 2
    B 2.5
    C 1.6", col_names = TRUE)


# default: dark bars
ggplot(d1, aes(x = cond, y = yval)) +
  geom_bar(stat = "identity")

# Bars with read outlines
ggplot(d1, aes(x = cond, y = yval)) +
  geom_bar(stat = "identity", colour = "#FF9999")

# Red fill, black outlines
ggplot(d1, aes(x = cond, y = yval)) +
  geom_bar(stat = "identity", fill = "#FF9999", colour = "black")

# Standard black lines and points
ggplot(d1, aes(x = cond, y = yval)) +
  geom_line(aes(group = 1)) +
  geom_point(size = 3)

ggplot(d1, aes(x = cond, y = yval)) +
  geom_line(aes(group = 1), colour = "#000099") + # Blue lines
  geom_point(size = 3, colour = "#CC0000") # Red dots
