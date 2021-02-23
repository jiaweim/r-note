# DataFrame

- [DataFrame](#dataframe)
  - [简介](#简介)
  - [创建数据框](#创建数据框)
  - [数据框属性](#数据框属性)
    - [列名](#列名)
    - [行名](#行名)
  - [数据框内容访问](#数据框内容访问)
    - [访问单个元素](#访问单个元素)
    - [访问列](#访问列)
    - [访问行](#访问行)
    - [范围选择](#范围选择)
  - [增强型数据框 tibble](#增强型数据框-tibble)
    - [CSV 格式字符串](#csv-格式字符串)

2020-08-29, 21:00
***

## 简介

数据框是矩形结构，包含行和列。统计分析中类似于 Excel 表格的数据最多，所以数据框（data.frame）在 R 中使用十分频繁。

数据框底层实现为列表，列表中的元素是向量，这些向量构成数据框的列，不过每一列必须具有相同的长度，而且列必须命令。

可以将数据框看作包含多种类型数据的矩阵。其特征有：

- column 名不能为空
- row names 必须唯一
- 可存储 numeric, factor 和 character 数据类型
- 每一列的数据类型必须相同

## 创建数据框

用 `data.frame` 函数，例如：

```r
> d <- data.frame(
+   name = c("Lili", "Lucy", "Dog"),
+   age = c(30, 35, 40),
+   height = c(180, 175, 160),
+   stringsAsFactors = FALSE
+ )
> print(d)
  name age height
1 Lili  30    180
2 Lucy  35    175
3  Dog  40    160
```

不同列用逗号隔开，每个参数左侧对应列名，右侧对应该列的值。

`data.frame()` 会将字符型列转换为因子，加选项 `stringsAsFactors = FALSE` 可以避免该转换。

用 `as.data.frame(x)` 可以将 x 转换为数据框：

- 如果 x 为向量，则 x 称为数据库唯一一列内容；
- 如果 x 为列表，且列表元素是长度相同的向量，则每个向量对应一列；
- 如果 x 为矩阵，则矩阵的列转换为数据框的列

## 数据框属性

|函数|功能|
|---|---|
|nrow(x)|x 的行数|
|ncol(x)|x 的列数|
|length(x)|x 的列数|
|names(x)|x 的列名|
|colnames(x)|x 的列名|

例如：

```r
> d <- data.frame(
+   name = c("Lili", "Lucy", "Dog"),
+   age = c(30, 35, 40),
+   height = c(180, 175, 160),
+   gender = c('F', "F", "M"),
+   stringsAsFactors = FALSE
+ )
> print(nrow(d))
[1] 3
> print(ncol(d))
[1] 4
> print(length(d))
[1] 4
> print(names(d))
[1] "name"   "age"    "height" "gender"
```

### 列名

数据框的每一列都有一个名称。给 `names(d)` 或 `colnames(d)` 赋值，可以给数据框 d 的列重命名。例如：

```r
> d <- data.frame(
+   name = c("Lili", "Lucy", "Dog"),
+   age = c(30, 35, 40),
+   height = c(180, 175, 160),
+   gender = c('F', "F", "M"),
+   stringsAsFactors = FALSE
+ )
> print(knitr::kable(d))

|name | age| height|gender |
|:----|---:|------:|:------|
|Lili |  30|    180|F      |
|Lucy |  35|    175|F      |
|Dog  |  40|    160|M      |
> names(d) <- c("name_a", "age_a", "height_a", "gender_a")
> print(knitr::kable(d))

|name_a | age_a| height_a|gender_a |
|:------|-----:|--------:|:--------|
|Lili   |    30|      180|F        |
|Lucy   |    35|      175|F        |
|Dog    |    40|      160|M        |
```

### 行名

数据框的每一行也可以有一个名称。不过在 tibble 中取消了该功能，如果需要行名，可以用 `left_join()` 函数添加一列作为行名。

使用 `rownames(d)` 获得行名，为其赋值则设置行名。例如：

```r
> rownames(d) <- d$name # 将行名设置为 name
> print(d)
     name age height gender
Lili Lili  30    180      F
Lucy Lucy  35    175      F
Dog   Dog  40    160      M
```

## 数据框内容访问

### 访问单个元素

格式：`frame[row,column]`

例如，对前面的数据框：

```r
> print(d[2, 3]) # 第2行第3列
[1] 175
```

### 访问列

- 格式：`frame[[col_index]]`

选择 `col_index` 索引对应的列，返回值为向量类型。例如：

```r
> print(d[[2]])
[1] 30 35 40
```

- 格式：`frame[,col_index]`

依然是选择 `col_index` 索引对应的列，由于只剩下一列，所以自动降维成向量。例如：

```r
> print(d[, 2])
[1] 30 35 40
```

如果不想降维，可以设置 `drop=FALSE`，例如：

```r
> print(d[, 2, drop = FALSE])
  age
1  30
2  35
3  40
```

- 格式：`frame[["col_name"]]`

选择 `col_name` 列名称对应的列，返回向量类型。例如：

```r
> print(d[["name"]])
[1] "Lili" "Lucy" "Dog"
```

- 格式：`frame["col_name"]`

和上面的格式相比，这个少一个方括号，返回的是数据框类型。例如：

```r
> y <- d["name"]
> print(y)
  name
1 Lili
2 Lucy
3  Dog
> print(is.data.frame(y))
[1] TRUE
```

- 格式：`frame[, "col_name"]`

选择列名对应的列，返回向量类型，和 tibble 不兼容，不推荐使用。例如：

```r
> print(d[, "name"])
[1] "Lili" "Lucy" "Dog"
```

- 格式：`frame$col_name`

选择列名对应的列，向量类型。例如：

```r
> print(d$name)
[1] "Lili" "Lucy" "Dog"
```

### 访问行

因为数据框的不同列的类型可以不一样，所以选择行，返回依然是数据框类型。例如：

```r
> x <- d[2,] # 选择第二行
> print(x)
  name age height gender
2 Lucy  35    175      F
> print(is.data.frame(x)) # 输出类型
[1] TRUE
```

### 范围选择

格式：`frame[row_range,col_range]`

如果只提供一个值，不管是索引还是名称，默认为列。

如果取出的是单列，则自动降维为向量，而不再是数据框。如果选择多列，则是数据框。所以使用该语法容易造成程序错误，在取单列时不要使用该语法。

如果不设置，默认为全部行或全部列。

例1：选择单列的行

```r
> print(d[1:2, "name"]) # 选择 name 列的1到2行
[1] "Lili" "Lucy"
```

例2：选择多列的行

```r
> print(d[1:2, c("name", "age")]) # 选择 name, age 这两列的1到2行
  name age
1 Lili  30
2 Lucy  35
```

例3：根据条件选择

```r
> print(d[d$age >= 35,])
  name age height gender
2 Lucy  35    175      F
3  Dog  40    160      M
```

例4：选择多列

```r
> print(d[c("name", "age")]) # 选择 name, age 这两列
  name age
1 Lili  30
2 Lucy  35
3  Dog  40
```

例5：使用名称选择多列

```r
> print(d[, c("name", "age")])
  name age
1 Lili  30
2 Lucy  35
3  Dog  40
```

例6：使用索引选择多列

```r
> print(d[1:2])
  name age
1 Lili  30
2 Lucy  35
3  Dog  40
```

## 增强型数据框 tibble

`tibble` 是增强的 `data.frame`，选取 `tibble` 的行或列，即使遇到当行或单列，数据也不会降维，总是返回 `tibble`。

- 不自动将字符串转换为因子。
- 不自动降维
- 定义时不需要列明合法，不过在引用变量名是需要用反撇号 `` 包起来。
- tibble 不支持行名，将数据框用 `as_tibble()` 转换为 tibble 时，可以用 `rownames="变量名"` 选项将行转换为 tibble 的一列，其中 "变量名" 对应该列名。
- tibble 允许列为列表类型。

例如：

```r
> tb <- tibble(
+     x=1:4,
+     y=4:1,
+     z=c("a", "b", "c", "d")
+ )
> tb
# A tibble: 4 x 3
      x     y z
  <int> <int> <chr>
1     1     4 a
2     2     3 b
3     3     2 c
4     4     1 d
> tb["x"]
# A tibble: 4 x 1
      x
  <int>
1     1
2     2
3     3
4     4
> tb[, "x"]
# A tibble: 4 x 1
      x
  <int>
1     1
2     2
3     3
4     4
```

### CSV 格式字符串

使用 `tribble` 可以按照类似于 CSV 的格式定义 tibble，例如：

```r
> tb <- tribble(
+   ~"index", ~"count",
+   1, 145,
+   5, 110,
+   6, NA,
+   9, 150,
+   10, NA,
+   15, 115
+ )
> print(tb)
# A tibble: 6 x 2
  index count
  <dbl> <dbl>
1     1   145
2     5   110
3     6    NA
4     9   150
5    10    NA
```

`tribble()` 除最后一行，每行末尾有逗号。
