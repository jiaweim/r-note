# IO

## 读矩形文件

下面的函数将矩形文件（如 csv 等固定宽度）读到 tibble中。在读取时指定文件的总体结构，指定每一行如何拆分为字段。

|文件格式| readr 函数|
|---|---|
|空格分隔文件|read_table(), read_table2()|

## 常见格式

|文件格式|R 函数|
|---|---|
|.txt|read.table()|
|.csv|read.csv() and readr::read_csv()|
|.xls and .xlsx|readxl::read_excel() and openxlsx::read.xlsx()|
|.sav|foreign::read.spss()|
|.Rdata or rda|load()|
|.rds|readRDS() and readr::read_rds()|
|.dta|haven::read_dta() and haven::read_stata()|
|Internet|download.file()|
