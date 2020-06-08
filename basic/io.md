# R IO

- [R IO](#r-io)
  - [控制台 IO](#控制台-io)
    - [scan](#scan)
    - [print](#print)
    - [cat](#cat)
    - [sink](#sink)
  - [键盘输入](#键盘输入)
  - [文件读写](#文件读写)
    - [常见格式](#常见格式)
  - [读取带分隔符的文本文件](#读取带分隔符的文本文件)
  - [CSV](#csv)
    - [read.csv](#readcsv)
    - [readr.read_csv](#readrread_csv)

2020-05-14, 10:58
*** *

## 控制台 IO

`scan()`, `readline()`, `print()` 和 `cat()` 函数用于控制台 IO。

### scan

```r
scan(file = "", what = double(), nmax = -1, n = -1, sep = "",
     quote = if(identical(sep, "\n")) "" else "'\"", dec = ".",
     skip = 0, nlines = 0, na.strings = "NA",
     flush = FALSE, fill = FALSE, strip.white = FALSE,
     quiet = FALSE, blank.lines.skip = TRUE, multi.line = TRUE,
     comment.char = "", allowEscapes = FALSE,
     fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)
```

参数说明：

- file

文件名，如果为 `""`，则从键盘读取。

如果为文件路径，对相对路径，从工作目录 `getwd()` 解析文件路径；或者以绝对路径指定。

- what

`what` 指定读取的数据类型，支持类型有 `logical`, `integer`, `numeric`, `complex`, `character`, `raw` 以及 `list`。

如果 `what` 为

`scan()` 从控制台或文件读取一个向量或 list。

例如，有四个文件：

- 文件 `z1.txt`

```txt
123
4 5
6
```

读取效果：

```r
> a <- scan("basic/z1.txt")
Read 4 items
> print(a)
[1] 123   4   5   6
> print(typeof(a))
[1] "double"
```

即结果为 `double` 类型的向量。

- 文件 `z2.txt`

```txt
123
4.2 5
6
```

读取效果：

```r
> b <- scan("basic/z2.txt")
Read 4 items
> print(b)
[1] 123.0   4.2   5.0   6.0
> print(typeof(b))
[1] "double"
```

- 文件 `z3.txt`

```txt
abc
de f
g
```

直接读取该文件报错：

```r
> v3 <- scan("basic/z3.txt")
Error in scan("basic/z3.txt") : scan() expected 'a real', got 'abc'
```

因为默认按照数字读取，对字符串，需要额外设置：

文件 `z4.txt`:

```txt
abc
123 6
y
```

```r
> a <- scan("basic/z1.txt")
Read 4 items
> print(a)
[1] 123   4   5   6
> print(typeof(a))
[1] "double"
```

返回的为 `double` 类型的向量。

### print

`print()` 函数显示某个变量或表达式的值，例如：

标量输出：

```r
> x <- 1.234
> print(x)
[1] 1.234
```

向量输出：

```r
> y <- c(1,3,5)
> print(y[2:3]) # 输出第二个和第三个元素
[1] 3 5
```

### cat

用 `cat()` 把字符串、变量、表达式连接起来显示，其中变量和表达式的类型一般是变量或向量，也可以是矩阵、列表等复杂数据。例如：

```r
> x <- 1.234
> cat("x = ", x, "\n")
x =  1.234
```

再比如：

```r
> cat("sin(pi/2) =", sin(pi/2), "\n")
sin(pi/2) = 1
```

`cat` 的最后一项 `\n` 用于换行。

### sink

`sink()` 可用于收集控制台输出，在 R 命令行中运行过的命令会被保存在工作文件夹的 `.Rhistory` 文件中。而使用 `sink()` 函数可以保存执行命令输出的内容。

`sink()` 打开一个文本，运行结束后再次调用 `sink()` 关闭文件：

```r
sink("tmpres01.txt", split=TRUE)
print(sin(pi/6))
print(cos(pi/6))
cat("t(10)的双侧0.05分位数（临界值）=", qt(1 - 0.05/2, 10), "\n")
sink()
```

`sink()` 用作输出记录，主要用在测试里，正常的输出应该使用 `cat()`、`write.table()`, `write.csv()` 等函数。

## 键盘输入

edit() 函数自动调用一个允许手动输入输入的文本编辑器。步骤：

1. 创建一个空的数据框（或矩阵），并制定好变量名和变量的类型
2. 针对该数据调用文本编辑器，输入你的数据，并将结果保存回数据对象。
这种输入方式，对小数据集比较合适。

例：

```r
mydata <- data.frame(age = numeric(0),
                     gender = character(0),
                     weight = numeric(0))
mydata <- edit(mydata)
```

说明：

- `numeric(0)` 指定类型但不包含实际数据
- `edit()`的返回值需要赋值回原对象.edit() 在对象的副本上进行操作，如果不赋值回原目标，数据丢失。

运行，弹出一个输入框：

![table](images/2019-09-01-16-07-09.png)

输入完成后，关掉窗口，数据会自动保存到对象中。

## 文件读写

文件的读写在工作目录中完成，使用 `getwd()` 获得工作命令，使用 `setwd("C:/data")` 设置工作目录。如果文件不在工作目录里，则必须给出它的路径。

### 常见格式

| 文件格式      | R函数                                           |
| ------------- | ----------------------------------------------- |
| txt           | `read.table()`                                  |
| csv           | `read.csv()`, `readr:read_csv()`                |
| xls, xlsx     | `readxl::read_excel()`, `openxlsx::read.xlsx()` |
| sav           | `foreign::read.spss()`                          |
| .Rdata or rda | `load()`                                        |
| rds           | `readRDS()` and `readr:read_rds()`              |
| dta           | `haven::read_dta()` and `haven::read_stata()`   |
| Internet      | `download.file()`                               |

基本范例：

```r
d <- read.table(file= "./data/txt_file.txt", header = TRUE)
load(file = "./data/rda_file.rda")

d <- readRDS(file = "./data/rds_file.rds")

library(readr)
d <- read_csv(file = "./data/csv_file.csv")

url <- "https://raw.githubusercontent.com/perlatex/R_for_Data_Science/master/demo_data/wages.csv"
d <- read_csv(url)

library(readxl)
d <- read_excel("./data/vowel_data.xlsx")

library(haven)
d <- read_excel("./data/cfps2010.dta")
```

## 读取带分隔符的文本文件

语法：

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

参数说明：

- file, 带分隔符的ASCII文本文件
- header，表面首行是否包含了变量名称
- sep, 指定分隔符
- row.names，可选参数，指定一个或多个表示行标识符的变量

字符型变量，默认读取为 factor类型，如果不希望如此，可以通过 read.table 的参数设置。

例如，读取CSV文件

```r
a_table <- read.table("io/input.csv", header = TRUE, sep = ",")
```

## CSV

### read.csv

读取 csv:

```r
data <- read.csv("input.csv")
print(data)
```

`read.csv` 返回的是 data frame 对象，

`read.csv()` 的一个改进版本是 `readr`包的 `read_csv()` 函数，此函数读入较大表格速度要快很多，而且读入的转换设置更倾向于不做不必要的转换。

### readr.read_csv
