
# Excel 文件

## 简介

读取 Excel 文件的最好方法，是在 Excel 中将其导出为 csv 文件。导出数据还解决了另一个问题。Excel 使用专有格式和元数据，直接转换为 R  不容易。例如，一个 Excel 文件可能包含多个表格，每个表格都有自己的列和宏。当 Excel 将其导出为 .csv 或 .txt 文件，Excel 会保证导出的正确性。而直接使用 R 可能无法保证转换的有效性。

此外，也可以使用 `readxl` 读取 .xls 和 .xlsx 文件。

### 复制粘贴

可以复制 Excel 表格的部分内容并粘贴到 R。从 Excel 复制数据后，使用 R 读取剪贴板：

```R
read.table("clipboard")
```

在 Mac 中：

```R
read.table(pipe("pbpaste"))
```

如果单元格包含带空格的值，`read.table()`  可能无法正确处理，此时可以采用其它 `read` 函数，或者直接从 Excel 导出 csv 文件。

### XLConnect

有许多包可以直接在 R 中读取 Excel 文件。可惜这些包大多无法跨平台工作，不过 `XLConnect` 包可以在所有文件系统工作。安装并加载：

```R
install.packages("XLConnect")
library(XLConnect)
```

XLConnect 依赖于 Java 平台，所以在第一次打开 XLConnect 时，RStudio 会要求安装 JRE。

### 读取 XLSX

用 XLConnect 读取 XSLX 文件可以采用一步或两步法。两步法：

1. 用 `loadWorkbook()` 加载 .xls 或 .xlsx 文件，采用为文件名

```R
wb <- loadWorkbook("file.xlsx")
```

2. 用 `readWorksheet()` 用 workbook 读取表格

- 第一个参数为 `loadWorkbook()` 返回的 workbook 对象；

- 第二个参数为 `sheet` 为表格名称或编号

`readWorksheet()` 余下四个参数指定要读取的单元格的范围：

- `startRow` 和 `endRow`
- `startCol` 和 `endCol`

如果不提供范围，`readWorksheet()` 读取包含数据的矩形区域。

`readWorksheet()` 假设该区域包含标题，可以用 `header = FALSE` 设置不包含标题。

例如：从 `wb` 读取第一个表格：

```R
sheet1 <- readWorksheet(wb, sheet = 1, startRow = 0, startCol = 0,
                        endRow = 100, endCol = 3)
```

R 将读取的数据保存为 data-frame。`readWorksheet()` 除了第一个参数，其它参数都是向量化的，因此可以使用它从一个 workbook 一次读取多个表格，返回 data-frame list。

以上两步可以合并为一步，用 `readWorksheetFromFile()` 函数直接从 Excel 文件读取一个或多个表格：

```R
sheet1 <- readWorksheetFromFile("file.xlsx", sheet = 1, startRow = 0,
	startCol = 0, endRow = 100, endCol = 3)
```

### 输出 XLSX

输出一个 Excel 文件分为 4 步：

1. 使用 `loadWorkbook()` 设置一个 workbook 对象

步骤和读取一样，只是添加参数 `create = TRUE`。XLConnect 会创建一个空的 workbook，保存时，XLConnect 会将数据写入指定的文件位置：

```R
wb <- loadWorkbook("file.xlsx", create = TRUE)
```

2. 使用 `createSheet()` 创建表格

```R
createSheet(wb, "Sheet 1")
```

3. 使用 `writeWorksheet()` 将 data-frame 或 matrix 对象保存到 sheet

```R
writeWorksheet(wb, data = poker, sheet = "Sheet 1")
```

- 第一个参数是待写入的 workbook 对象
- 第二个参数 `data` 是待输出的数据
- 第三个参数 `sheet` 是待写入 sheet 的名称
- 参数 `startRow` 和 `startCol` 指定将数据写入表格哪个位置，默认均为 1
- `header` 表示是否同时输出 column names

4. 使用 `saveWorkbook()` 保存 workbook

R 会将 workbook 保存到 `loadWorkbook()` 指定的文件位置。如果该位置已有文件，则覆盖它。

调用 `writeWorksheetToFile` 可以将这 4 个步骤合并为一步：

```R
writeWorksheetToFile("file.xlsx", data = poker, sheet = "Sheet 1",
  startRow = 1, startCol = 1)
```

XLConnect 还有许多高级功能，包括使用公式、单元格样式等，具体可参考 XLConnect 文档。

## xlsx

- `read_excel()` 将工作表一对一地导入 tibble 数据框

`readxl` 包的 `read_excel()` 可用于读取 `.xls` 和 `.xlsx` 文件。

```r
# Only need to install once
install.packages('readxl')

library(readxl)
data <- read_excel('datafile.xlsx', 1)
```

可以通过名称或索引指定读取的 sheet：

```r
data <- read_excel('datafile.xls', sheet = 2)

data <- read_excel('datafile.xls', sheet = 'Revenues')
```

`read_excel()` 使用第一行作为 column 名称。如果不希望如此，可以设置 `col_names=FALSE`。此时 columns 默认名称为 `X1`, `X2` 等。

另外，`read_excel()` 会自动推断每列的数据类型，也可以使用 `col_types` 参数指定类型。将特定列的类型指定为 `'blank'` 则删除该列：

```r
# Drop the first column, and specify the types of the next three columns
data <- read_excel('datafile.xls',
                   col_types = c('blank', 'text', 'date', 'numeric'))
```