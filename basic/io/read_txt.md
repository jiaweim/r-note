# 纯文本文件

## read.table

可以使用 `read.table()` 从带分隔符的文本文件导入数据。该函数读取一个表格格式的文件，并将其保存为数据框。语法如下： 

```R
read.table(file, header = FALSE, sep = "", quote = "\"'",
           dec = ".", numerals = c("allow.loss", "warn.loss", "no.loss"),
           row.names, col.names, as.is = !stringsAsFactors, tryLogical = TRUE,
           na.strings = "NA", colClasses = NA, nrows = -1,
           skip = 0, check.names = TRUE, fill = !blank.lines.skip,
           strip.white = FALSE, blank.lines.skip = TRUE,
           comment.char = "#",
           allowEscapes = FALSE, flush = FALSE,
           stringsAsFactors = FALSE,
           fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)

read.csv(file, header = TRUE, sep = ",", quote = "\"",
         dec = ".", fill = TRUE, comment.char = "", ...)

read.csv2(file, header = TRUE, sep = ";", quote = "\"",
          dec = ",", fill = TRUE, comment.char = "", ...)

read.delim(file, header = TRUE, sep = "\t", quote = "\"",
           dec = ".", fill = TRUE, comment.char = "", ...)

read.delim2(file, header = TRUE, sep = "\t", quote = "\"",
            dec = ",", fill = TRUE, comment.char = "", ...)
```

使用 `read.table()` 读取纯文本文件，第一个参数为文件名。`read.table()`有很多参数，常用选项：

| 选项               | 说明                                                         |
| ------------------ | ------------------------------------------------------------ |
| `header`           | 文件第一行是否为变量名                                       |
| `sep`              | 数据分隔符。默认 `sep = ""` 标识一个或多个空格、制表符、换行或回车。使用 `sep = ","` 来读取 CSV 文件，使用 `sep = "\t"` 来读取 TSV 文件 |
| `row.names`        | 一个指定 row 名称的向量。单个数字标识包含 row 名称的 column 的索引；单个字符串标识包含 row 名称的 column 的名称；或者是提供实际 row 名称的向量。<br />如果包含 header，并且第一行包含的字段数比 column  数少 1 个，那么输入数据的第一列将用作 row names。如果未指定 `row.names`，则对行自动编号。<br />使用 `row.names = NULL` 强制对 row 编号。 |
| `col.names`        | 包含变量名称的向量。默认使用 "V" 加上列编号命名，例如 "V1", "V2" |
| `na.strings`       | 表示缺失值的字符串。所有匹配该字符串的值，`read.table()` 将其转换为 NA，例如 `na.strings==c("-9", "?")` 在读取过程中会把 -9 与 ? 转换为 NA |
| `colClasses`       | 指定 column 类型。例如，`colClasses=c("numeric", "numeric", "character", "NULL", "numeric")` 把前两列读取为数值型向量，第三列读取为字符型向量，跳过第四列，第五列读取为数值型向量。如果数据超过 5 列，`colClasses` 的值被循环。在读取大型文本文件时，加上 `colClasses` 可以提高处理速度 |
| `quote`            | 一组用于表示引号的字符。使用 `quote = ""` 完全禁用引号功能。关于引号中嵌套引号的处理行为，请查阅 `scan` 函数的说明。引号仅在读取为字符型（character）的列时才会被识别；除非指定了 `colClasses` 参数，否则所有列默认都会被读取为字符型 |
| `skip`             | 整数（integer）：在开始读取数据之前，需要跳过的数据文件的行数 |
| `stringsAsFactors` | 逻辑值（logical）：是否应将字符型向量（character vectors）转换为因子（factors）？请注意，`as.is` 和 `colClasses` 参数会覆盖此设置，因为这两个参数允许你进行更精细的控制 |
| `text`             | 字符串（character string）：如果未提供 `file` 参数，而是提供了该参数，那么数据将从 `text` 的值中读取。即使用字面字符串在 R 代码中直接内嵌（小型）数据集 |



- `skip` 和 `nrow`

有些纯文本文件开头包含一段介绍性文字，它们不属于数据集；或者你只想读取一部分数据。

`skip` 表示开头跳过的行数；`nrow` 表示读取该行数后停止。

例如，下面的数据，需要跳过前 3 行，然后读取剩下的 5 行：

```
This data was collected by the National Poker Institute.
We accidentally repeated the last row of data.

"card", "suit", "value"
"ace", "spades", 14
"king", "spades", 13
"queen", "spades", 12
"jack", "spades", 11
"ten", "spades", 10
"ten", "spades", 10
```

```R
read.table("poker.csv", sep = ",", header = TRUE, skip = 3, nrow = 5)
```

标题行不包含在 `nrow` 中。

- `stringsAsFactors`

R 默认会将字符串转换为 factor，但这并不合理（R4.4 默认不转换为 factor）。因此建议保证 `stringsAsFactors = FALSE`：

```R
read.table("poker.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
```

也可以在全局改变默认行为：

```R
options(stringsAsFactors = FALSE)
```

这就确保所有字符串被读取为字符串，而不是 factor，直到你结束当前 R 会话，或者再次修改全局设置：

```R
options(stringsAsFactors = TRUE)
```

### read Family

R 附带了特定设置的 `read.table` 快捷方式：

| 函数          | 配置                              | 使用          |
| ------------- | --------------------------------- | ------------- |
| `read.table`  | `sep="", header=FALSE`            | 通用          |
| `read.csv`    | `sep = ",", header=TRUE`          | csv 文件      |
| `read.delim`  | `sep = "\t", header=TRUE`         | tab 文件      |
| `read.csv2`   | `sep = ";", header=TRUE, dec=","` | 欧洲 csv 文件 |
| `read.delim2` | `sep="\t", header=TRUE, dec=","`  | 欧洲 tab 文件 |

> [!NOTE]
>
> 欧洲用逗号作为小数点，分号作为分隔符。

## readr

相比 R 基础函数，readr 中的函数具有很多优点：

