library(readr)

d.cancer <- readr::read_csv("src/data/cancer.csv", locale=locale(encoding="GBK"))
res <- table(d.cancer[,'sex'])
print(res)
barplot(res)