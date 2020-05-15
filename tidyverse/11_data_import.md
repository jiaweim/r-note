# Data import

- [Data import](#data-import)
  - [简介](#%e7%ae%80%e4%bb%8b)

## 简介

使用 `readr` 包读取纯文本文件，首先导入 `tidyverse` 包：

```r
library(tidyverse)
```

readr 的大部分函数将纯文本文件读取为数据框：

- `read_csv()` 读取 csv 文件
- `read_csv2()` 读取分号分隔的文件
- `read_tsv()` 读取 tab 分隔文件
- `read_delim()` 读取指定分隔符分隔的文件

