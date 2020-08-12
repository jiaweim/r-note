library(readr)

d.class <- read_csv("src/data/class.csv")

pairs(d.class[, c('age', 'height', 'weight')])
