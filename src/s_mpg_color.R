library(tidyverse)

mpg <- ggplot2::mpg
ggplot(data = mpg) + geom_point(mapping = aes(x=displ, y=hwy), color="blue")
