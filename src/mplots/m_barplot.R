library(tidyverse)

data <- read_csv("Z:\\MaoJiawei\\dataset\\results\\delta_histogram.csv")
knitr::kable(data)

plot_data <- data %>% 
  pivot_longer(c("IGD-O", "SEQUEST"),
               names_to="Search Engine",
               values_to="# GPSM")
knitr::kable(plot_data)

#   
# 
# gplot <- ggplot(data=data, mapping = aes(x='Delta Name', y=))
# print(data)