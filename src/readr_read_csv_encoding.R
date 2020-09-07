library(readr)

d.bp <- read_csv(file = "src/data/bp.csv",
                 locale = locale(encoding = "GBK"))
print(d.bp)