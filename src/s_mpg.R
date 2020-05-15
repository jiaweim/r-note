library(tidyverse)

df <- ggplot2::mpg
ggplot(data = df)+geom_point(mapping = aes(x=displ, y=hwy))