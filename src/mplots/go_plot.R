library(ggplot2)
library(dplyr)

go.data <- read_csv("Z:\\MaoJiawei\\dataset\\results\\gProfiler_hsapiens.csv",
                    col_names = TRUE,
                    col_types = "cc--d--i--")

go.top <- go.data %>%
  group_by(source) %>%
  slice_max(negative_log10_of_adjusted_p_value, n = 8)

go.go <- go.top %>%
  filter(source == "GO:BP" |
           source == "GO:CC" |
           source == "GO:MF")

go.kegg <- go.top %>%
  filter(source == "KEGG" |
           source == "REAC")

mp <- ggplot(go.go, aes(x = term_name, y = intersection_size)) +
  geom_col(aes(fill = negative_log10_of_adjusted_p_value)) +
  scale_fill_gradient( name = bquote(`-log_{10}p.adjust`)) +
  coord_flip() +
  facet_grid(source ~ ., scales = "free") +
  labs(x = "", y = "")

print(mp)

