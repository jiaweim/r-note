library(tidyverse)
library(gapminder)

p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))

pp <- p + geom_point(alpha = 0.5) +
  geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::dollar) +
  labs(
    x = "人均GDP",
    y = "期望寿命（年）",
    title = "经济增长与期望寿命",
    subtitle = "数据点为每个国家每年",
    caption = "数据来源：gapminder"
  )
print(pp)
