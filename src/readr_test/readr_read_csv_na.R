library(readr)

bp.data <- read_csv(file = "../data/bp.csv",
                    locale = locale(encoding = "GBK"),
                    col_types = cols(
                      `序号` = col_integer(),
                      `收缩压` = col_double()
                    ))
print(bp.data)