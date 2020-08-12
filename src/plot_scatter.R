library(readr)

d.class <- read_csv("src/data/class.csv")

plot(d.class$height, d.class$weight)

with(d.class,
     plot(height, weight,
          main="体重与身高的关系",
          xlab = "身高",ylab = "体重",
          pch=16, col='blue', cex=2))