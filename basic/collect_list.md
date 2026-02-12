# List

2020-06-15, 20:47
*** *

## 简介

许多数据集包含多种类型的信息。向量、矩阵和数组都只能存储一种类型的数据，优点是存储和计算快。

列表，和向量一样将数据放在一维集合中，不同的是：

- 向量存储的是单个数值列表
- list 存储的是 R 对象列表

因此 list 可以包含**不同类型**的数据，可以包含 vector, function 甚至其它 list。

列表的一个主要功能是提供 R 分析结果。如结果包含回归系统、预测值、残差、检验结果等一系列不能放到规则形状数据结构中的内容。

## 创建 List

```r
list(…)
pairlist(…)
as.list(x, …)
# S3 method for environment
as.list(x, all.names = FALSE, sorted = FALSE, …)
as.pairlist(x)

is.list(x)
is.pairlist(x)

alist(…)
```

使用 `list()` 创建列表，使用方式与 `c()` 创建向量类似，不同元素用逗号分隔：

```R
> list1 <- list(100:120, "R", list(TRUE, FALSE))
> list1
[[1]]
 [1] 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117
[19] 118 119 120

[[2]]
[1] "R"

[[3]]
[[3]][[1]]
[1] TRUE

[[3]][[2]]
[1] FALSE
```

在输出中：`[[1]]` 表示第一个元素，`[[2]]` 表示第二个元素，等等。

可以使用 `names()` 给列表中元素命名。列表中元素可以使用索引访问，也可以使用名字进行访问。使用 `unlist()` 将列表转换为向量。

```r
> list_data <- list(c('Google', "Baidu", "Taobao"), matrix(c(1, 2, 3, 4, 5, 6), nrow = 2), list('baidu', 12.3))
# 为元素是何止名称
> names(list_data) <- c("Sites", "Numbers", "Lists")
> print(list_data)
$Sites
[1] "Google" "Baidu"  "Taobao"

$Numbers
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6

$Lists
$Lists[[1]]
[1] "baidu"

$Lists[[2]]
[1] 12.3
# 添加元素
> list_data[4] <- "new"
# 删除元素
> list_data[4] <- NULL
# 更新元素
> list_data[3] <- "update"
> list_data
$Sites
[1] "Google" "Baidu"  "Taobao"

$Numbers
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6

$Lists
[1] "update"
```

```r
> j <- list(name="Joe", salary=5500,  union=T)
> j
$name
[1] "Joe"

$salary
[1] 5500

$union
[1] TRUE

> typeof(j)
[1] "list"
```

> `T` 表示 TRUE。

列表中各元素的名称称为标签。

`typeof()` 函数返回对象类型，为 "List"。可以用 `is.list()` 函数判断某个对象是否为列表类型。

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

### 使用 `vector` 创建

因为列表是向量，因此可以使用 `vector()` 创建列表。

```r
> z <- vector(mode = "list")
> z[["abc"]] <- 3
> z
$abc
[1] 3
```

使用起来语法冗长，不推荐。

## 索引

对列表，使用 `[` 返回列表，`[[` 和 `$` 返回列表中的元素：

- `[` 返回一个新的列表
- `[[` 返回列表中的元素
- `[["a"]]` 也是返回列表中的元素
- `x$a` 是 `x[["a"]]` 的简写

例如：

```r
> j <- list(name="Joe", salary=5500,  union=T)
> j$salary
[1] 5500
> j[["salary"]]
[1] 5500
> j[[2]]
[1] 5500
```

列表一般都应该有元素名（列表类型 Java 的 Map，Python 的 dict），用 `names()` 函数查看和修改元素名。例如：

```r
> j <- list(name="Joe", salary=5500, unit=T)
> names(j)
[1] "name"   "salary" "unit"  
> names(j)[names(j) == "unit"] <- "score"
> names(j)
[1] "name"   "salary" "score"
```

修改内容：

```r
> j$name <- "LiLei"
> j
$name
[1] "LiLei"

$salary
[1] 5500

$score
[1] TRUE
```

直接给列表不存在的元素名赋值，添加了新元素。比如：

```r
> j$home <- "wuhan"
> j
$name
[1] "LiLei"

$salary
[1] 5500

$score
[1] TRUE

$home
[1] "wuhan"
```

## NULL 值

把列表元素赋值为 NULL 就删除了这个元素。例如：

```r
> j$home <- NULL
> j
$name
[1] "LiLei"

$salary
[1] 5500

$score
[1] TRUE
```

不过在 `list()` 函数中允许定义值为 `NULL` 的元素。例如：

```r
> li <- list(a=120, b='female', c=NULL)
> li
$a
[1] 120

$b
[1] "female"

$c
NULL
```

要将已存在的元素修改为 NULL，而不是删除该元素，

此时需要用 `[]` 取子集，给这样的子列表赋值为 `list(NULL)`。例如：

```r
> li
$a
[1] 120

$b
[1] "female"

$c
NULL

> li['b'] <- list(NULL)
> li
$a
[1] 120

$b
NULL

$c
NULL
```

## 列表类型转换

用 `as.list()` 把其它类型转换为列表，用 `unlist()` 把列表转换为向量。例如：

```r
> li1 <- as.list(1:3)
> li1
[[1]]
[1] 1

[[2]]
[1] 2

[[3]]
[1] 3

> li2 <- list(x=1, y=c(2, 3))
> unlist(li2)
 x y1 y2
 1  2  3
```

## strsplit

`strsplit()` 将输入字符向量的每个字符串，用指定分隔符分隔，返回一个列表，每个列表对应字符串的每个拆分结果。例如：

```r
> x <- c("4, 8, 6", "4, 3, 1", "6, 7, 9")
> res <- strsplit(x, ",")
> res
[[1]]
[1] "4"  " 8" " 6"

[[2]]
[1] "4"  " 3" " 1"

[[3]]
[1] "6"  " 7" " 9"
```

对数值型字符串，可以用 `sapply()` 将拆分结果转换为矩阵：

```r
> sapply(res, as.numeric)
     [,1] [,2] [,3]
[1,]    4    4    6
[2,]    8    3    7
[3,]    6    1    9
```

## 参考

- https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/list