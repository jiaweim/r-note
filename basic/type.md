# R 数据类型

2024-09-04 ⭐
@author Jiawei Mao
***

## 存储模式与基本类型

R 的变量可以存储多种数据类型， 可以用 `typeof()` 函数获得一个变量或表达式的类型。比如

```r
> typeof(1:3)
[1] "integer"
> typeof(c(1, 2, 3))
[1] "double"
> typeof(c(1, 2.1, 3))
[1] "double"
> typeof(c(TRUE, NA, FALSE))
[1] "logical"
> typeof('AbC')
[1] "character"
> typeof(factor(c('F', 'M', 'M', 'F')))
[1] "integer"
```

> 注意因子的类型是 `integer` 而不是因子

`mode()` 和 `storage.mode()` 功能与 `typeof()` 类似，这是为了与 S 语言兼容所遗留的，应避免使用。

R中数据的基本类型包括 `logical`, `integer`, `double`, `character`, `complex`, `raw`, 其它数据类型都是由基本类型组合或转变得到的，它们又称为原子类型。

- `character` 类型就是字符串类型。
- `raw` 类型是直接使用其二进制内容的类型。

原子类型的向量中元素都是同一基本类型的。比如，double型向量的元素都是double或者缺失值。

### 判断类型

为了判断某个向量x保存的基本类型， 可以用 `is.xxx()` 类函数， 如

- `is.integer(x)`
- `is.double(x)`
- `is.numeric(x)`
- `is.logical(x)`
- `is.character(x)`
- `is.complex(x)`
- `is.raw(x)`

其中 `is.numeric(x)` 对 `integer` 和 `double` 内容都返回真值。

在R语言中数值一般看作 `double`, 如果需要明确表明某些数值是整数， 可以在数值后面附加字母L，如

```r
> is.integer(c(1, -3))
[1] FALSE
> is.integer(c(1L, -3L))
[1] TRUE
```

### 缺失值

整数型的缺失值是 `NA`， 而 `double` 型的特殊值除了 `NA` 外， 还包括 `Inf`, `-Inf` 和 `NaN`， 其中 `NaN` 也算是缺失值, Inf和-Inf不算缺失值。 如:

```r
> c(-1, 0, 1)/0
[1] -Inf  NaN  Inf
> is.na(c(-1, 0, 1)/0)
[1] FALSE  TRUE FALSE
```

对 `double` 类型

- 用 `is.finite()` 判断是否有限值， NA、Inf, -Inf和NaN都不是有限值；
- 用 `is.infinite()` 判断是否Inf或-Inf
- `is.na()` 判断是否NA或NaN
- `is.nan()` 判断是否NaN

严格说来:

- `NA` 表示逻辑型缺失值，但是当作其它类型缺失值时一般能自动识别。
- `NA_integer_` 是整数型缺失值，
- `NA_real_` 是double型缺失值，
- `NA_character_` 是字符型缺失值。

## 逻辑类型

TRUE，简写 T
FALSE, 简写 F

逻辑运算

```r
> T & F
[1] FALSE
> T | F
[1] TRUE
> !T
[1] FALSE
> !F
[1] TRUE
```

## NULL

R有一个特殊的 `NULL` 类型， 这个类型只有唯一的一个NULL值， 表示不存在。 NULL长度为0， 不能有任何属性值。 用 `is.null()` 函数判断某个变量是否取NULL。

`NULL` 值可以用来表示类型未知的零长度向量， 如 `c()` 没有自变量时返回值就是 `NULL`； 也经常用作函数缺省值， 在函数内用 `is.null()` 判断其缺省后再用一定的计算逻辑得到真正的缺省情况下的数值。

要把 `NULL` 与 `NA` 区分开来， NA是有类型的（integer、double、logical、character等), `NA` 表示存在但是未知。 数据库管理系统中的`NULL` 值相当于R中的NA值。

## 类型转换与升档

使用 `as.xxx()` 函数在不同类型之间进行强制转换。

- `as.numeric()` 把内容是数字的字符串转换为数值。
- `as.character()` 把数值型转换为字符串，如果变量本来就是数值，则结果不变。

如：

```r
> as.character(1)
[1] "1"
> as.logical(1)
[1] TRUE
> as.numeric(FALSE)
[1] 0
```

类型转换也可能是隐式的，比如，四则运算中数值会被统一转换为 `double` 类型，逻辑运算中运算元素会被统一转换为 `logical` 类型。

逻辑值转换成数值时，`TRUE` 转换成1，`FALSE` 转换成0。

在用 `c()` 函数合并若干元素时，如果元素基本类型不同， 将统一转换成最复杂的一个，复杂程度从简单到复杂依次为：

$$
logical<integer<double<character
$$
这种做法称为**类型提升**，例如：

```r
> c(FALSE, 1L, 2.5, "3.6")
[1] "FALSE" "1"     "2.5"   "3.6"  
```

不同类型参与要求类型相同的运算时，也会统一转换为最复杂的类型，如：

```r
> TRUE + 10
[1] 11
> paste("abc", 1)
[1] "abc 1"
```

使用逻辑值进行数学运算时，R 使用相同的类型提升：

```R
> sum(c(TRUE, TRUE, FALSE, FALSE))
[1] 2
```

等价于：

```R
> sum(c(1, 1, 0, 0))
[1] 2
```

## 属性

属性是可以附加到任何 R 对象的一段信息。

除了 `NULL` 以外， R的变量都可以看成是对象，都可以有属性。在R语言中，属性是把变量看成对象后，除了其存储内容（如元素）之外的其它附加信息， 如维数、类属等。 R对象一般都有 `length` 和 `mode` 两个属性。

向量最常见的属性包括 name, dimension 和 class。这三个属性都有对应的辅助函数，使用对应函数可以设置或查看属性。

### attributes 函数

使用 `attributes` 函数查看对象属性。

- 没有属性返回 NULL

```R
> die
[1] 1 2 3 4 5 6
> attributes(die)
NULL
```

例如：

```r
> x <- table(c(1, 2, 1, 3, 2, 1))
> print(x)

1 2 3
3 2 1
> attributes(x)
$dim
[1] 3

$dimnames
$dimnames[[1]]
[1] "1" "2" "3"


$class
[1] "table"
```

`table()` 函数用于输出其变量中每个不同值出现的次数。从上例可以看出，`table()` 函数的结果有三个属性：

- `dim` 和 `dimnames` 是数组属性
- `class` 属性，为类型名称

因为 x 是数组，所以可以访问：

```r
> x[1]
1
3
> x["3"]
3
1
```

也可以用 `attributes()` 函数修改属性，如

```r
> attributes(x) <- NULL
> x
[1] 3 2 1
```

修改后，x 不再是数组，也不是 table。

### attr 函数

可以用 `attr(x, "属性名")` 读取或定义x的属性。 如：

```r
> x <- c(1, 3, 4)
> attr(x, "theta") <- c(0, 1)
> x
[1] 1 3 4
attr(,"theta")
[1] 0 1
```

这样可以向量 x 额外地保存一个 `theta` 属性，这列属性常常称为“元数据”(meta data)， 比如，用来保存数据的说明、模拟数据的真实模型参数，等等。

### names 属性

有名称的向量、列表、数据框等都有 `names` 属性，许多 R 函数的输出本质上也是列表，所以也有 `names` 属性。 用 `names(x)` 读取或设定 names 属性。例如：

```R
> die <- c(1,2,3,4,5,6)
> names(die)
NULL
```

`NULL` 表示 `die` 没有 names 属性。

- 可以用 `names` 函数设置属性：

```R
> names(die) <- c("one", "two", "three", "four", "five", "six")
> names(die)
[1] "one"   "two"   "three" "four"  "five"  "six"  
> attributes(die)
$names
[1] "one"   "two"   "three" "four"  "five"  "six"  

> die
  one   two three  four  five   six 
    1     2     3     4     5     6 
```

查看向量时，R 会在元素上方显示名称。

- 但是，names 属性不影响向量值，对向量值进行操作也不影响 names 属性。例如：

```R
> die + 1
  one   two three  four  five   six 
    2     3     4     5     6     7 
```

- 用 `names` 修改 names 属性

```R
> names(die) <- c("uno", "dos", "tres", "quatro", "cinco", "seis")
> die
   uno    dos   tres quatro  cinco   seis 
     1      2      3      4      5      6 
```

- 用 `names` 删除 names 属性

```R
> names(die) <- NULL
> die
[1] 1 2 3 4 5 6
```

### dim 属性

`dim` 属性设置向量维度。例如：

```R
> die <- c(1,2,3,4,5,6)
> die
[1] 1 2 3 4 5 6
> dim(die) <- c(2,3)
> die
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```

或者将 `dim` 设置为 3 行 2 列：

```R
> dim(die) <- c(3,2)
> die
     [,1] [,2]
[1,]    1    4
[2,]    2    5
[3,]    3    6
```

设置可以设置为 (1, 2, 3)，表示 1 行 2 列 3 个 slice。只要乘积和元素总数一致就行：

```R
> dim(die) <- c(1, 2, 3)
> die
, , 1

     [,1] [,2]
[1,]    1    2

, , 2

     [,1] [,2]
[1,]    3    4

, , 3

     [,1] [,2]
[1,]    5    6
```

> [!NOTE]
>
> R 将 `dim` 的第一个值作为 row 数，第二个值作为 column 数。
>
> R 总是按 column 填充。如果需要更好的控制填充方式，可以采用 matrix 或 array 函数。

R允许 `dim` 仅有一个元素，对应一维向量，这与没有 `dim` 属性的向量还是有区别。 另外要注意，取矩阵子集时如果结果仅有一列或一行， 除非用了 `drop=FALSE` 选项，结果不再有 `dim` 属性，退化成了普通向量。

## class 属性

R 具有一定的面向对象语言特征，其数据类型有一个 `class` 属性， 函数`class()` 可以返回变量类型的类属性， 比如

```r
> typeof(factor(c('F', 'M', 'M', 'F')))
[1] "integer"
> mode(factor(c('F', 'M', 'M', 'F')))
[1] "numeric"
> storage.mode(factor(c('F', 'M', 'M', 'F')))
[1] "integer"
> class(factor(c('F', 'M', 'M', 'F')))
[1] "factor"
> class(as.numeric(factor(c('F', 'M', 'M', 'F'))))
[1] "numeric"
```

如果一个对象具有 `class` 属性，则一些通用函数会针对这类对象进行专门操作，比如 `print()` 函数在显示向量和回归结果时采用完全不同的格式。在其它程序设计语言中称为重载。

使用 `dim` 修改 dim 属性不会改变对象类型，但是会改变 `class` 属性。例如：

```R
> die <- c(1,2,3,4,5,6)
> die
[1] 1 2 3 4 5 6
> typeof(die)
[1] "double"
> class(die)
[1] "numeric"

> dim(die) <- c(2,3)
> typeof(die)
[1] "double"
> class(die)
[1] "matrix" "array" 
```

`class` 属性描述 `die` 的格式。许多 R 函数会根据对象的 `class` 属性处理数据。

`attributes` 有时候不显示 `class` 属性，此时要用 `class()` 来显式查询：

```R
> attributes(die)
$dim
[1] 2 3

> class(die)
[1] "matrix" "array" 
```

对没有 `class` 属性的对象，`class()` 返回**对象的原子类型**。

```R
> class("Hello")
[1] "character"
> class(5)
[1] "numeric"
```

> [!NOTE]
>
> double 的 `class` 属性为 "numeric"。

### Date Time

R 的属性系统使 R 能表示更多的数据类型。例如，R 使用一个特殊的类表示日期和时间。例如：

```R
> now <- Sys.time()
> now
[1] "2024-09-04 13:59:42 CST"
> typeof(now)
[1] "double"
> class(now)
[1] "POSIXct" "POSIXt" 
```

`Sys.time()` 返回计算机的当前时间。显示看起来像一个字符串，但它的数据类型实际上是 `double`，其 class 为 `POSIXct` 和 `POSIXt`。

POSIXct 是一个广泛使用的表示日期和时间的框架，每个时间都用从 1970年1月1日上午 12:00 开始的秒数来描述。例如，上例的时间发生在 1970年1月1日 12:00 后的 1725429582 秒，因此在 POSIXct 系统，该时间保存为 1725429582。

R 通过一个 double 向量创建 time 对象，即 1725429582。用 `unclass` 函数移除 `now` 的 `class` 属性，就可以看到该 double 值：

```R
> unclass(now)
[1] 1725429582
```

R 为该 double 向量添加两个 `class` 属性：POSIXct 和 POSIXt.

这两属性告诉 R 函数它们在处理的是 POSIXct 时间，因此它们能以时间的方式处理它。例如，R 函数在显示时间前使用 POSIXct 标准将时间转换为用户友好的字符串。

可以将 `POSIXct` class 属性赋予其它 R 对象。例如，你想知道 1970年1月1日12:00 1百万秒后是什么日子？

```R
> mil <- 1000000
> mil
[1] 1e+06
> class(mil) <- c("POSIXct", "POSIXt")
> mil
[1] "1970-01-12 21:46:40 CST"
```

是 1970 年 1 月 12 日。

这个转换很容易，`POSIXct` class 不依赖其它属性，但一般来说，强制使用对象的 class 属性不合适。

R 中有许多不同的数据类，其中 factor 类在 R 中使用十分普遍，具体参考 [factor](./data_factor.md)。

## str() 函数

用 `print()` 函数可以显示对象内容。如果内容很多，显示行数可能也很多。 用 `str()` 函数可以显示对象的类型和主要结构及典型内容。例如

```r
> attr(s, 'author') <- '小明'
> attr(s, 'date') <- '2020-07-04'
> str(s)
 int [1:101] 0 1 2 3 4 5 6 7 8 9 ...
 - attr(*, "author")= chr "<U+5C0F><U+660E>"
 - attr(*, "date")= chr "2020-07-04"
```
