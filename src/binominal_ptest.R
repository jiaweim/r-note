library(dplyr)
library(ggplot2)

tibble(heads = 0:10,
       pmf = dbinom(x = 0:10, size = 10, prob = 0.3),
       cdf = pbinom(q = 0:10, size = 10, prob = 0.3)
) %>%
  mutate(Heads = ifelse(heads <= 4, "<=5", ">5")) %>%
  ggplot(aes(x = factor(heads), y = cdf, fill = Heads)) +
  geom_col() +
  geom_text(
    aes(label = round(cdf, 2), y = cdf + 0.01),
    position = position_dodge(0.9),
    size = 3,
    vjust = 0
  ) +
  labs(title = "Probability of X <= 5 successes.",
       subtitle = "b(10, 0.3)",
       x = "Successes (x)",
       y = "Probability"
  )
