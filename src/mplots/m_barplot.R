library(tidyverse)

data <- read_csv("Z:\\MaoJiawei\\dataset\\results\\delta_histogram.csv")

plot_data <- data %>%
  pivot_longer(c("IGD-O", "SEQUEST"),
    names_to = "Search Engine",
    values_to = "# GPSM"
  )
knitr::kable(plot_data)


gplot <- ggplot(
  data = plot_data,
  mapping = aes(
    x = `Delta Name`,
    y = `# GPSM`,
    fill = `Search Engine`
  )
)

gp <- gplot + 
  geom_col(position = "dodge") + 
  coord_flip() + 
  labs(x = "") + 
  theme_light()+
  theme(legend.position = "none")

print(gp)
