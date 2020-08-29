library(tidyverse)

#pdf("m_bar.pdf")

data <- read_csv("Z:\\MaoJiawei\\dataset\\results\\delta_histogram.csv")

plot_data <- data %>%
  pivot_longer(c("IGD-O", "SEQUEST"),
               names_to = "Search Engine",
               values_to = "# GPSM"
  )
#knitr::kable(plot_data)

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
  theme_light() +
  theme(legend.position = "none") +
  scale_fill_manual(values = c("#e2533a", "#5465ae"))

gp + theme(panel.grid.minor = element_blank()) # 隐藏部分网格线

#dev.off()
ggsave("bar.pdf")