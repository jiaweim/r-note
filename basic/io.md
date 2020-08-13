# R IO

- [R IO](#r-io)
  - [控制台 IO](#控制台-io)
    - [scan](#scan)
    - [print](#print)
    - [cat](#cat)
    - [sink](#sink)
    - [save](#save)
  - [键盘输入](#键盘输入)
  - [文件读写](#文件读写)
    - [常见格式](#常见格式)
    - [read.table](#readtable)
  - [读取带分隔符的文本文件](#读取带分隔符的文本文件)
  - [CSV](#csv)
    - [`read.csv`](#readcsv)
    - [readr.read_csv](#readrread_csv)
    - [从字符串读取数据](#从字符串读取数据)
    - [编码设置](#编码设置)
    - [缺失值](#缺失值)
    - [列类型设置](#列类型设置)
  - [xlsx](#xlsx)

2020-05-14, 10:58
*** *

## 控制台 IO

`scan()`, `readline()`, `print()` 和 `cat()` 函数用于控制台 IO。

### scan

`scan()` 可以从控制台或文件读取数值向量。

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

输出输入：

```r
cat(1:12, "\n", file="d:/work/x.txt")
x <- scan("d:/work/x.txt")
```

如果没有给出文件参数，则从命令读入数据。可以在一行用空格隔开多个数据，也可以多行输入直到空行结束输入。

使用该方法可以读入矩阵，假设文件 `mat.txt` 包含如下矩阵：

```txt
3  4  2
5 12 10
7  8  6
1  9 11
```

可以先把文件读入到向量，再使用 `matrix()` 函数转换为矩阵。注意使用 `byrow=TRUE` 选项，同时指定 `ncol` 选项。例如：

```r
M <- matrix(scan("mat.txt", quiet=TRUE), ncol=3, byrow=TRUE)
```

`scan()` 中的 `quite=TRUE` 使得读入时不自动显示读入的数值数目。

上面读入数值矩阵的方法在数据量较大时可以使用。

`read_table()` 和 `readr::read_table()` 也可以读入这样的数据，但是会保存为数据框而不是矩阵，而且 `read_table()` 在读取大规模矩阵时效率很低。

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

用 `cat()` 把字符串、变量、表达式连接起来显示，其中变量和表达式一般是标量或向量，不能为矩阵、列表等复杂数据。例如：

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

`cat()` 默认显示在命令行窗口，要写入文件，可以在 `cat()` 中添加 `file=` 选项，如果已经文件，默认覆盖文件，否则在 `cat()` 中使用 `append=TRUE` 选项以追加内容。例如：

```r
cat("=== 结果文件 ===\n", file="res.txt")
cat("x =", x, "\n", file="res.txt", append=TRUE)
```

### sink

`sink()` 可用于收集控制台运行结果。

在 R 命令行中运行过的命令会被保存在工作文件夹的 `.Rhistory` 文件中。而使用 `sink()` 函数可以保存执行命令输出的内容。

`sink()` 打开一个文本，运行结束后再次调用 `sink()` 关闭文件：

```r
sink("tmpres01.txt", split=TRUE)
print(sin(pi/6))
print(cos(pi/6))
cat("t(10)的双侧0.05分位数（临界值）=", qt(1 - 0.05/2, 10), "\n")
sink()
```

`sink()` 用作输出记录，主要用在测试里，正常的输出应该使用 `cat()`、`write.table()`, `write.csv()` 等函数。

设置 `split=TRUE` 可以在写入文件时，同时在控制台输出：

```r
sink("allres.txt", split=TRUE)
```

### save

在 R 命令行中定义的变量、函数会保存在工作空间中， 并在退出 R 会话时可以保存到硬盘文件中。 用 `save()` 命令可以把指定的若干个变量（直接用名字，不需要表示成字符串） 保存到用 `file=` 指定的文件中， 随后可以用 `load()` 命令恢复到工作空间中。

虽然允许保存多个变量到同一文件中， 但应该尽可能仅保存一个变量， 而且使用变量名作为文件名。 用 `save()` 保存的R特殊格式的文件是通用的， 不依赖于硬件和操作系统。 如

```r
save(scores, file="scores.RData")
load("scores.RData")
```

保存多个变量，如：

```r
save(x, zeta, file="myvars20200315.RData")
```

或：

```r
save(x, zeta, file="myvars20200315.RData")
```

对数据框，可以用 `write.csv()` 或 `readr::write_csv()` 将其保存为 CSV 文本文件。比如：

```r
da <- tibble("name"=c("李明", "刘颖", "张浩"),
                 "age"=c(15, 17, 16))
write_csv(da, path="mydata.csv")
```

生成的 mydata.csv 文件内容如下：

```csv
name,age
李明,15
刘颖,17
张浩,16
```

不过，在 Windows 操作系统中，默认编码是 GBK编码，而用 `write_csv()` 生成的 CSV 文件是 UTF-8 编码，而 MS Office 不能自动识别这样的CSV文件，可以改用 `write_csv_excel()` 函数。

R 基本的 `write.csv()` 函数不存在该问题。

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

### read.table

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
```

1. file


- **header**

文件第一行是否为标题。

- **na.strings**

字符串向量，用于指定设置为 `NA` 的所有字符串。在 logical, integer, numeric 以及 complex 字段中的空白字符也被解释为缺失值。

另外，在测试时会提前取出字符串前后的空格，所以在指定 `na.strings` 也应该去除前后空格。例如，将 '?' 指定为缺失值：

```r
read.table ("Auto.data", header =T,na.strings ="?")
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

`read.csv` 对 `read.table`  进行了包装，从而更便于读取 CSV 文件。

## CSV

对文本格式的表格数据，可以使用 R 自带的 `read.csv()`, `read.table()`, `read.delim()` 和 `read.fwf()` 等函数读取，但是建议使用 readr 包的 `read_csv()`, `read_table2()`, `read_delim()` 和 `read_fwf()` 函数读取，存储为 tibble 类型。tibble 是数据框的一个变种，改善了数据框一些不合适的设计。readr 读取速度比 `read.csv()` 等函数快得多，速度可以相差十倍，不自动就爱那个字符型列转换为因子，不自动修改变量名为合法变量名，不设置行名。

CSV 文件用逗号分隔开同一行的数据，一般第一行是各列的列名（变量名）。对于数值型数据，只要表示成数值常量形式即可。 对于字符型数据，可以用双撇号包围起来，也可以不用撇号包围。 但是，如果数据项本身包含逗号，就需要用双引号包围。 例如，下面是一个名为 test.csv 的文件内容， 其中演示了内容中有逗号、有双撇号的情况。

```csv
id,words
1,"PhD"
2,Master's degree
3,"Bond,James"
4,"A ""special"" gift"
```

读取数据：

```r
d <- read_csv("testcsv.csv")
```

### `read.csv`

读取 csv:

```r
data <- read.csv("input.csv")
print(data)
```

`read.csv` 返回的是 data frame 对象，

如果文件没有标题，设置不读取标题：

```r
data <- read.csv('datafile.csv', header = FALSE)
```

此时默认标题为 `V1`, `V2` 等。可以使用如下方式重命名标题：

```r
names(data) <- c('Column1', 'Column2', 'Column3')
```

还可以使用 `sep` 设置分隔符，例如：

```r
data <- read.csv('datafile.csv', sep = '\t')
```

`read.csv` 默认将字符串存储为 factor。假如你想用 `read.csv` 读取下面的文件：

```csv
'First','Last','Sex','Number'
'Currer','Bell','F',2
'Dr.','Seuss','M',49
'','Student',NA,21
```

返回的 frame 默认以 factor 存储 `First` 和 `Last`，虽然此时存储为字符串更合适。设置 `stringsAsFactors = FALSE` 可以避免字符串存储为 factor。如果某些列需要存储为 factor，可以再单独转换：

```r
data <- read.csv('datafile.csv', stringsAsFactors = FALSE)

# Convert to factor
data$Sex <- factor(data$Sex)
str(data)
#> 'data.frame': 3 obs. of 4 variables:
#> $ First : chr 'Currer' 'Dr.' ''
#> $ Last : chr 'Bell' 'Seuss' 'Student'
#> $ Sex : Factor w/ 2 levels 'F','M': 1 2 NA
#> $ Number: int 2 49 21
```

当然，也可以采用默认的 factor，然后将 factor 转换为字符串。

`read.csv()` 的一个改进版本是 `readr`包的 `read_csv()` 函数，此函数读入较大表格速度要快很多，而且读入的转换设置更倾向于不做不必要的转换。

### readr.read_csv

`skip=` 选项用于跳过开头的若干行。当数据不包含列明，需指定 `col_names=FALSE`，变量名自动命名为 `X1`, `X2`...，也可以使用 `col_names=` 指定各列的名称，例如：

```r
> d.small <- read_csv("John, 33, 95
+                     Kim, 21, 64
+                     Sandy, 49, 100", col_names=c("name", "x", "y"))
> d.small
# A tibble: 3 x 3
  name      x     y
  <chr> <dbl> <dbl>
1 John     33    95
2 Kim      21    64
3 Sandy    49   100
```

### 从字符串读取数据

`read_csv()` 可以从字符串读取数据库。例如：

```r
> d.small <- read_csv("name,x,y
+                     John, 33, 95
+                     Kim, 21, 64
+                     Sandy, 49, 100")
> d.small
# A tibble: 3 x 3
  name      x     y
  <chr> <dbl> <dbl>
1 John     33    95
2 Kim      21    64
3 Sandy    49   100
```

### 编码设置

CSV是文本文件，对中文有编码问题。 readr包的默认编码是UTF-8。 例如，文件bp.csv 以GBK编码（有时称为GB18030编码， 这是中文Windows所用的中文编码）保存了如下内容：

```csv
序号,收缩压
1,145
5,110
6, 未测
9,150
10, 拒绝
15,115
```

直接读取：

```r
> d <- read_csv("src/data/bp.csv")
Parsed with column specification:
cols(
  `<d0><f2><U+00BA><c5>` = col_double(),
  `<ca><d5><cb><f5><U+0479>` = col_character()
)
> d
Error in nchar(x[is_na], type = "width") :
  invalid multibyte string, element 1
```

设置编码读取：

```r
> d <- read_csv("src/data/bp.csv", locale=locale(encoding = "GBK"))
Parsed with column specification:
cols(
  `<U+5E8F><U+53F7>` = col_double(),
  `<U+6536><U+7F29><U+538B>` = col_character()
)
> d
# A tibble: 6 x 2
  `序号` `收缩压`
   <dbl> <chr>
1      1 145  
2      5 110  
3      6 未测
4      9 150  
5     10 拒绝
6     15 115
```

### 缺失值

`read_csv` 将空缺的值读入为缺失值，将 "NA" 也读入为缺失值。可以用 `na=` 选项修改默认设置。也可以将带缺失值的列原样读入，再进行转换。

比如，对前面的 `bp.csv` 文件，先将血压按字符型读入，再增加一列转换为数值型的列，非数值转换为 NA：

```r
> d <- read_csv("src/data/bp.csv", locale = locale(encoding = "GBK"))
> d[["收缩压数值"]] <- as.numeric(d[["收缩压"]])
> d
# A tibble: 6 x 3
  `序号` `收缩压` `收缩压数值`
   <dbl> <chr>           <dbl>
1      1 145               145
2      5 110               110
3      6 未测               NA
4      9 150               150
5     10 拒绝               NA
6     15 115               115
```

### 列类型设置

对每列的类型，`readr` 使用前 1000 行猜测合理的类型，并在读取后显示猜测的每列类型。

但是有可能类型改变发生在 1000 行之后。 `col_types` 选项可以指定每一列的类型：

- `col_double()`
- `col_integer()`
- `col_character()`
- `col_factor()`
- `col_date()`
- `col_datetime`

`cols()` 函数可以用来设置各列类型， `.default` 参数指定缺省类型。 对因子，需要在 `col_factor()` 中用 `lelvels=` 指定因子水平。

可以使用 `readr` 猜测的类型作为 `col_types` 的输入， 这样当数据变化时不会因为偶尔猜测错误而使得程序出错。如

```r
> d <- read_csv("src/data/bp.csv", locale = locale(encoding = "GBK"),
+               col_types = cols(
+                   '序号'=col_integer(),
+                   '收缩压'=col_character()
+               ))
> d
# A tibble: 6 x 2
  `序号` `收缩压`
   <dbl> <chr>
1      1 145  
2      5 110  
3      6 未测
4      9 150  
5     10 拒绝
6     15 115  
```

当猜测的文件类型有问题的时候，可以先将所有列读取为字符类型，然后用 `type_convert()` 函数转换，如：

```r
d <- read_csv("filename.csv",
              col_types=cols(.default = col_character()))
d <- type_convert(d)
```

对特大文件可以先少读取一些行，用 `nmax=` 设置最大读入行。调试成功后再读入整个文件。

## xlsx

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

