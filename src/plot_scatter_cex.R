library(readr)

d.class <- read_csv("src/data/class.csv")

with(d.class,
     plot(height, weight,
          main="体重与身高的关系",
          xlab = "身高",ylab = "体重",
          pch=16, 
          col=ifelse(sex=='M', "blue", "red"), 
          cex=1+(age-min(age))/(max(age)-min(age))))