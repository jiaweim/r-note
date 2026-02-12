# read.table

读取表格样式的文件，返回 data frame。

```r
read.table(file, header = FALSE, sep = "", quote = "\"'",
           dec = ".", numerals = c("allow.loss", "warn.loss", "no.loss"),
           row.names, col.names, as.is = !stringsAsFactors,
           na.strings = "NA", colClasses = NA, nrows = -1,
           skip = 0, check.names = TRUE, fill = !blank.lines.skip,
           strip.white = FALSE, blank.lines.skip = TRUE,
           comment.char = "#",
           allowEscapes = FALSE, flush = FALSE,
           stringsAsFactors = default.stringsAsFactors(),
           fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)
read.csv(file, header = TRUE, sep = ",", quote = "\"",
         dec = ".", fill = TRUE, comment.char = "", …)

read.csv2(file, header = TRUE, sep = ";", quote = "\"",
          dec = ",", fill = TRUE, comment.char = "", …)

read.delim(file, header = TRUE, sep = "\t", quote = "\"",
           dec = ".", fill = TRUE, comment.char = "", …)

read.delim2(file, header = TRUE, sep = "\t", quote = "\"",
            dec = ",", fill = TRUE, comment.char = "", …)
```

- **file**

文件名称。返回表格的每个 row 对应文件的一行。如果不是绝对路径，相对路径从当前 working-directory 开始。支持压缩文件。


- **header**

文件第一行是否为标题。

- **dec**

文件中用于表示小数点的字符。

- **na.strings**

字符串向量，用于指定设置为 `NA` 的所有字符串。在 logical, integer, numeric 以及 complex 字段中的空白字符也被解释为缺失值。

另外，在测试时会提前取出字符串前后的空格，所以在指定 `na.strings` 也应该去除前后空格。例如，将 '?' 指定为缺失值：

```r
read.table ("Auto.data", header =T,na.strings ="?")
```

- **fill**

logical；TRUE 表示当 row 长度不一致，隐式添加空白字段。

