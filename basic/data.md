# R 数据类型

- [R 数据类型](#r-数据类型)
  - [基本类型](#基本类型)
    - [数值](#数值)
    - [字符串](#字符串)
    - [逻辑](#逻辑)
  - [数据结构](#数据结构)
  - [factor](#factor)
    - [factor 实例](#factor-实例)
    - [tapply](#tapply)
    - [Ordered factor](#ordered-factor)
  - [对象](#对象)
  - [矩阵](#矩阵)
    - [矩阵操作](#矩阵操作)
    - [对角元](#对角元)
  - [数组](#数组)
  - [List](#list)
    - [创建 List](#创建-list)
    - [索引](#索引)
  - [数据框](#数据框)
  - [增强型数据框 tibble](#增强型数据框-tibble)

2020-05-28, 19:20
*** **

## 基本类型

| 类型      | 说明                    |
| --------- | ----------------------- |
| numeric   | 0, 1, -2, 3.1415, 0.005 |
| character | "America", "31"         |
| logical   | TRUE, FALSE             |
| factor    | Levels: a b c           |

### 数值

```r
> a <- 0.001
> class(a)
[1] "numeric"
> mode(a)
[1] "numeric"
```

### 字符串

```r
> b <- "Hello"
> class(b)
[1] "character"
```

### 逻辑

```r
> c <- TRUE
> class(c)
[1] "logical"
```

## 数据结构

和 C 及 java 不同，R 和 python 一样，在声明变量时不指定数据类型。

R 没有标量，单个数值作为向量的特例来处理，它通过各种类型的向量来存储数据。

R 语言中，变量类型称为模式（mode）。

R 包含多种数据类型，常用的有：Vector, List, Matrix, Array, Factor, Data Frame。

其中 vector 是最简单数据类型，有 6 种原子向量，或者称为 6 种向量。

![types](images/2020-05-28-22-27-06.png)

说明：

- 向量是一个变量，和常规认知的向量含义一致。
- 因子是分类变量。
- 数组是 k 维的数据表
- 矩阵是数组的一个特例，其维度为2
- 数据库由一个或几个向量或因子构成，它们必须等长，但可以是不同类型
- 列表可以包含任意类型的对象，包括列表。

## factor

在 R 中，factor 是一种特殊的向量，用于指定其它相同长度向量元素的离散分类（分组）。R 提供了有序和无序 factors。

```r
> f <- factor(c("a", "b", "c"))
> f
[1] a b c
Levels: a b c
> class(f)
[1] "factor"
```

### factor 实例

假如有来自澳大利亚各地区的 30 名会计师的样本，用一个字符向量提供他们各自来自哪个州。如下：

```r
> state <- c("tas", "sa",  "qld", "nsw", "nsw", "nt",  "wa",  "wa",
+            "qld", "vic", "nsw", "vic", "qld", "qld", "sa",  "tas",
+            "sa",  "nt",  "wa",  "vic", "qld", "nsw", "nsw", "wa",
+            "sa",  "act", "nsw", "vic", "vic", "act")
```

> 对字符向量，排序是指按字母顺序排列。

使用向量创建 factor:

```r
> statef <- factor(state)
```

factor 输出：

```r
> statef
 [1] tas sa  qld nsw nsw nt  wa  wa  qld vic nsw vic qld qld sa  tas sa  nt  wa  vic qld nsw nsw wa
[25] sa  act nsw vic vic act
Levels: act nsw nt qld sa tas vic wa
```

使用 `levels()` 函数查看所有的 levels:

```r
> levels(statef)
[1] "act" "nsw" "nt"  "qld" "sa"  "tas" "vic" "wa"
```

对正数，如：

```r
> x <- c(5, 12, 13, 12)
> xf <- factor(x)
> xf
[1] 5  12 13 12
Levels: 5 12 13
```

额外信息 level 可以表示等级，或者说类别。再看 `xf` 内部信息：

```r
> str(xf)
 Factor w/ 3 levels "5","12","13": 1 2 3 2
> unclass(xf)
[1] 1 2 3 2
attr(,"levels")
[1] "5"  "12" "13"
```

其中的 `1 2 3 2` 可以看作数据分类。

还可以在定义时指定 level:

```r
xff <- factor(x, levels = c(5, 12, 13, 88))
```

虽然 `xff` 不含有 88，但是额外的level是允许的。

### tapply

继续上面的例子，假设我们有另一个向量，该向量包含所有会计的收入：

```r
> incomes <- c(60, 49, 40, 61, 64, 60, 59, 54, 62, 69, 70, 42, 56,
+              61, 61, 61, 58, 51, 48, 65, 49, 49, 41, 48, 52, 46,
+              59, 46, 58, 43)
```

要计算每个地区的平均收入，此时可以使用 `tapply()` 函数：

```r
> incmeans <- tapply(incomes, statef, mean)
> incmeans
     act      nsw       nt      qld       sa      tas      vic       wa
44.50000 57.33333 55.50000 53.60000 55.00000 60.50000 56.00000 52.25000
```

`tapply()` 将指定函数（第三个参数，如 mean）应用到向量（第一个参数，如 incomes）的每个分组，分组由第二个参数（此处为 `statef`）确定。返回结果的长度和 factor 相同。

`tapply(x, f, g)`

- x 对应向量
- f 对应因子
- g 对应函数

假设我们还想计算收入的标准差。为此我们首先需要实现计算标准差的函数。已有内置函数 `var()` 计算样本方差，该函数是一个很简单呐的线性函数：

```r
> stdError <- function(x) sqrt(var(x)/length(x))
```

然后，我们就可以使用该函数计算不同地区收入的标准差：

```r
> incster <- tapply(incomes, statef, stdError)
> incster
     act      nsw       nt      qld       sa      tas      vic       wa
1.500000 4.310195 4.500000 4.106093 2.738613 0.500000 5.244044 2.657536
```

### Ordered factor

Factor 的 levels 按照字母顺序存储，或者根据指定的顺序存储。

而 levels 有时具有自然顺序，如数值类型。`Ordered()` 函数用于创建此类有序 factor，这类 factor 其它行为和常规 factor 一样。

大多时候，有序和无序 factor 的唯一差别是，输出的level具有顺序。

## 对象

`mode` 函数获取对象的类型，`length` 获得对象长度。例如：

```r
> x <- 1
> mode(x)
[1] "numeric"
> length(x)
[1] 1
> a <- "Hello World"
> mode(a)
[1] "character"
> compar <- TRUE
> mode(compar)
[1] "logical"
> z <- 1i
> mode(z)
[1] "complex"
```

无论什么类型的数据，缺失值总是用 NA 表示。对很大的数值可以用指数：

```r
> N <- 2.1e23
> N
[1] 2.1e+23
```

无穷数用 `Inf` 表示：

```r
> x <- 5/0
> x
[1] Inf
```

字符型的值输入时必须加上双引号，如果需要使用双引号，可以用反斜杠 `\`。

## 矩阵

```r
> m <- matrix(c(2, 4, 6, 1, 3, 8), nrow = 2, ncol = 3, byrow = TRUE)
> m
     [,1] [,2] [,3]
[1,]    2    4    6
[2,]    1    3    8
```

### 矩阵操作

```r
> a <- matrix(1:9, nrow = 3)
> a
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9
```

取第1行和第二行的 2-3 列，用 `[1:2, 2:3]`，得到一个新的矩阵：

```r
> a[1:2, 2:3]
     [,1] [,2]
[1,]    4    7
[2,]    5    8
```

`[` 默认将获取的数据尽可能以低的维度呈现，比如：

```r
> a[1, 1:2]
[1] 1 4
```

表示第一行的前两列，此时不是 $1\times2$矩阵，而是包含两个元素的向量。

保留所有的行或列，例如选取1到2行的所有列，可以如下简写：

```r
> a[1:2, ]
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
```

即，省略掉对应位置的索引即可。

### 对角元

`diag(m)` 返回矩阵的对角元。

## 数组

```r
> ar <- array(c(11:14, 21:24, 31:34), dim = c(2, 2, 3))
> ar
, , 1

     [,1] [,2]
[1,]   11   13
[2,]   12   14

, , 2

     [,1] [,2]
[1,]   21   23
[2,]   22   24

, , 3

     [,1] [,2]
[1,]   31   33
[2,]   32   34
```

## List

列表，可以包含不同类型的数据，如vector, function 甚至其他的 list。

R 中的列表和 Python 的字典很像。

### 创建 List

```r
> j <- list(name="Joe", salary=5500,  union=T)
> j
$name
[1] "Joe"

$salary
[1] 5500

$union
[1] TRUE
```

> `T` 表示 TRUE。

列表中各元素的名称称为标签。

其中标签是可选的，可以不指定。

```r
> k <- list("Joe", 5500, T)
> k
[[1]]
[1] "Joe"

[[2]]
[1] 5500

[[3]]
[1] TRUE
```

可以看到默认标签为 `[1]`, `[2]`, `[3]`。

在使用的时候，标签可以简写，只写前面几个字母，只要不引起歧义，R 都能识别：

```r
> j$sal
[1] 5500
```

因为列表是向量，因此可以使用 `vector()` 创建列表。

```r
> z <- vector(mode = "list")
> z[["abc"]] <- 3
> z
$abc
[1] 3
```

使用起来语法冗长，不推荐。

### 索引

对列表，使用 `[` 返回列表，`[[` 和 `$` 返回列表中的元素。例如：

```r
> j <- list(name="Joe", salary=5500,  union=T)
> j$salary
[1] 5500
> j[["salary"]]
[1] 5500
> j[[2]]
[1] 5500
```

总结：

- `[` 返回一个新的列表
- `[[` 返回列表中的元素
- `[["a"]]` 也是返回列表中的元素
- `x$a` 是 `x[["a"]]` 的简写

## 数据框

数据框 `data.frame` 具有 List 和 Matrix 的属性，因此：

- 可以和 List 一样，根据位置选择列，如 `df[1:2]` 选择前两列
  - `df["x"]` 选择 `x` 列，返回新的矩阵
  - `df[["x"]]` 选择 `x` 列，返回向量
  - `df$x` 等价于 `df[["x"]]`
- 像矩阵一样，使用行和列选择，如 `df[1:3, ]` 选择前三行的所有列

```r
> df <- data.frame(x=1:4,
+                  y=4:1,
+                  z=c("a", "b", "c", "d"))
> df
  x y z
1 1 4 a
2 2 3 b
3 3 2 c
4 4 1 d
> # like list
> df[c("x", "z")] # 选择 x 和 z 这两列
  x z
1 1 a
2 2 b
3 3 c
4 4 d

> # like matrix
> df[, c("x", "z")] # 所有行，x 和 z 这两列
  x z
1 1 a
2 2 b
3 3 c
4 4 d
> df[1:2] # 选择 1 到 2 列，所有行
  x y
1 1 4
2 2 3
3 3 2
4 4 1
> df[1:3, ] # 选择 1-3 行，所有列
  x y z
1 1 4 a
2 2 3 b
3 3 2 c
```

和矩阵一样，当数据只剩下单行或单列，数据会降维：

```r
> df[, "x"]
[1] 1 2 3 4
```

如果不想降维，可以设置 `drop`:

```r
> df[, "x", drop=FALSE]
  x
1 1
2 2
3 3
4 4
```

## 增强型数据框 tibble

`tibble` 是增强型的 `data.frame`，选取 `tibble` 的行或列，即使遇到当行或单列，数据也不会降维，总是返回 `tibble`。例如：

```r
> tb <- tibble::tibble(
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
