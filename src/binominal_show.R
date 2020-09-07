library(dplyr)
library(ggplot2)

data.frame(heads = 0:10,
           prob = dbinom(x = 0:10, size = 10, prob = 0.3)) %>%
  mutate(Heads = ifelse(heads == 2, "2", "Other")) %>%
  ggplot(aes(x = factor(heads), y = prob, fill = Heads)) +
  geom_col() +
  geom_text(
    aes(label = round(prob, 2), y = prob + 0.01),
    position = position_dodge(0.9),
    size = 3,
    vjust = 0
  ) +
  labs(title = "Probability of X=2 successed.",
       subtitle = "b(10, 0.3)",
       x = "Successes (x)",
       y = "probability"
  )