# CSV

- [CSV](#csv)
  - [简介](#简介)
  - [read.csv](#readcsv)
  - [readr.read_csv](#readrread_csv)
    - [从字符串读取数据](#从字符串读取数据)
    - [编码设置](#编码设置)
    - [缺失值](#缺失值)
    - [列类型设置](#列类型设置)

2021-02-22, 15:48
***

## 简介

对文本格式的表格数据，可以使用 R 自带的 `read.csv()`, `read.table()`, `read.delim()` 和 `read.fwf()` 等函数读取，但是建议使用 readr 包的 `read_csv()`, `read_table2()`, `read_delim()` 和 `read_fwf()` 函数读取，存储为 tibble 类型。

tibble 是数据框的一个变种，改善了数据框一些不合理的设计。readr 读取速度比 `read.csv()` 等函数快得多，速度可以相差十倍，不自动将字符型列转换为因子，不自动修改变量名为合法变量名，不设置行名。

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

## read.csv

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

## readr.read_csv

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
