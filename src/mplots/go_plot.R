library(ggplot2)
library(dplyr)

go.data <- read_csv("Z:\\MaoJiawei\\dataset\\results\\gProfiler_hsapiens.csv",
                    col_names = TRUE,
                    col_types = "cc--d--i--")

go.top <- go.data %>%
  group_by(source) %>%
  slice_max(negative_log10_of_adjusted_p_value, n = 8)

