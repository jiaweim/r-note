# CSV

- [CSV](#csv)
  - [简介](#简介)
  - [从字符串读入](#从字符串读入)
  - [read_csv 选项](#read_csv-选项)
  - [编码设置](#编码设置)
  - [缺失值设置](#缺失值设置)
  - [类型设置](#类型设置)

2020-08-25, 21:37
@jiawei
***

## 简介

对 CSV 文件格式，可以用 `read.csv()`, `read.table()`, `read.delim()`, `read.fwf()` 等内置函数读取，但是建议使用 readr 包的 `read_csv()`, `read_table2()`, `read_delim()`, `read_fwf()` 等函数。

这些函数将读入的数据保存为 tibble 类型，读入速度比基本 R 的 `read.csv()` 等函数快许多，极端情况可以相差10倍，也不自动将字符串转换成因子，不自动修改变量名为合法变量名，不设置行名。

对于中小规模的数据，CSV格式作为文件交换格式比较合适， 兼容性强， 各种数据管理软件与统计软件都可以很容易地读入和生成这样格式的文件， 但是特别大型的数据读入效率很低。

CSV格式的文件用逗号分隔开同一行的数据项， 一般第一行是各列的列名（变量名）。 对于数值型数据， 只要表示成数值常量形式即可。 对于字符型数据， 可以用双撇号包围起来， 也可以不用撇号包围。 但是， 如果数据项本身包含逗号， 就需要用双撇号包围。

`read_csv`：

```r
read_csv(file, col_names = TRUE, col_types = NULL,
  locale = default_locale(), na = c("", "NA"), quoted_na = TRUE,
  quote = "\"", comment = "", trim_ws = TRUE, skip = 0,
  n_max = Inf, guess_max = min(1000, n_max),
  progress = show_progress(), skip_empty_rows = TRUE)
```

## 从字符串读入

```r
library(readr)

d.small <- read_csv("name,x,y
John, 33, 95
Kim, 21, 64
Sandy, 49, 100
")
print(d.small)
```

输出：

```r
# A tibble: 3 x 3
  name      x     y
  <chr> <dbl> <dbl>
1 John     33    95
2 Kim      21    64
3 Sandy    49   100
```

## read_csv 选项

`read_csv` 的 `skip=` 选项指定跳过开头的行数，默认为0.

`col_names=` 指定第一行是否为标题，`col_names=FALSE` 表示文件没有标题行，此时变量自动命名为 `X1, X2,...`。`col_names=` 还可以用来指定各列的名称，例如：

```r
library(readr)

d.small <- read_csv("John, 33, 95
Kim, 21, 64
Sandy, 49, 100", col_names = c("name", "x", "y"))
print(d.small)
```

输出：

```r
# A tibble: 3 x 3
  name      x     y
  <chr> <dbl> <dbl>
1 John     33    95
2 Kim      21    64
3 Sandy    49   100
```

## 编码设置

CSV文件是文本文件，所有有编码问题，尤其是包含中文的文件。 readr的默认编码是UTF-8。 例如，文件bp.csv以GBK编码（中文Windows所用的中文编码）保存了如下内容：

```r
序号,收缩压
1,145
5,110
6, 未测
9,150
10, 拒绝
15,115
```

如果直接使用 `read_csv("bp.csv")` 读取，可能会报错。此时可以用 `locale` 参数指定文件编码：

```r
library(readr)

d.bp <- read_csv(file = "src/data/bp.csv",
                 locale = locale(encoding = "GBK"))
print(d.bp)
```

## 缺失值设置

`read_csv()` 将空缺的值和 "NA" 读入为缺失值。可以用 `na=` 选项修改读作缺失值的值。当然也可以原样读取，后续再进行转换。依然是对前面的 bp.csv 文件：

```r
> bp.data <- read_csv(file = "src/data/bp.csv", locale = locale(encoding = "GBK"))
Parsed with column specification:
cols(
  `<U+5E8F><U+53F7>` = col_double(),
  `<U+6536><U+7F29><U+538B>` = col_character()
)
```

可以看到，第二列被读作了字符串，而实际内容为数值，我们将其内容转换：

```r
> bp.data[["收缩压数值"]] <- as.numeric(bp.data[["收缩压"]])
Warning: NAs introduced by coercion
> print(bp.data)
Warning: `...` is not empty.

We detected these problematic arguments:
* `needs_dots`

These dots only exist to allow future extensions and should be empty.
Did you misspecify an argument?
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

## 类型设置

对每列的类型， readr 用前 1000 行猜测合理的类型，并在读取后显示猜测的每列类型。

也可以使用 `col_types` 选项指定每列的类型。对应参数：

- `col_double()`
- `col_integer()`
- `col_character()`
- `col_factor()`
- `col_date()`
- `col_datetime`

`cols()` 函数可以用来指定各列类型，`.default` 参数指定缺省类型。对因子，在 `col_factor()` 中需要用 `levels=` 指定因子水平。
