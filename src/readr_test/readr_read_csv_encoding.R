library(readr)

d.bp <- read_csv(file = "../data/bp.csv",
                 locale = locale(encoding = "GBK"))
print(d.bp)