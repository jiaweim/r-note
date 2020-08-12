# 字符串

- [字符串](#字符串)
  - [字符串向量](#字符串向量)
  - [连接字符串 - paste](#连接字符串---paste)
  - [paste0](#paste0)
  - [大小写](#大小写)
  - [字符串长度](#字符串长度)
  - [子字符串](#子字符串)
  - [类型转换](#类型转换)
  - [sprintf](#sprintf)
  - [字符串拆分](#字符串拆分)
  - [字符串替换](#字符串替换)
  - [正则表达式](#正则表达式)

2020-06-01, 22:11
*** *

## 字符串向量

```r
s1 <- c('abc', '', 'a cat', NA, '李磊')
```

元素为字符串的向量。

## 连接字符串 - paste

`paste` 函数用于连接多个字符串，默认以空格连接。例如：

```r
> paste(c('ab', 'cd'), c('ef', 'gh'))
[1] "ab ef" "cd gh"
```

`paste()` 在连接字符串向量时遵守 R 的向量间运算规则，可以自动把数值型向量转换为字符串，可以一对多连接，例如：

```r
> paste("x", 1:3)
[1] "x 1" "x 2" "x 3"
```

通过 `sep=` 指定分隔符，例如：

```r
> paste("x", 1:3, sep = "")
[1] "x1" "x2" "x3"
```

使用 `collapse=` 可以将字符串向量的各个元素连在一起。例如：

```r
> paste(c('a', 'b', 'c'), collapse = "")
[1] "abc"
```

## paste0

`paste0()` 等价于 `paste(sep="")`。

## 大小写

`toupper()` 转换为大写。

`tolower()` 转换为小写。

```r
> toupper('aBc')
[1] "ABC"
> tolower(c("Ab", "cD", "EF"))
[1] "ab" "cd" "ef"
```

## 字符串长度

`nchar(x, type='bytes')` 计算字符串向量 x 的每个字符串以字节为单位的长度。中文一个汉字通常占两个字节，英文字母、数字和标点占一个字节。

```r
> nchar(c('a', 'bc', 'DEF', '测试'), type='bytes')
[1] 1 2 3 6
```

`nchar(x, type='chars')` 计算字符型向量 x 中每个字符串的字符数。例如：

```r
> nchar(c('a', 'bc', 'DEF', '测试'), type='chars')
[1] 1 2 3 2
```

在画图时，可以用 `strwidth()` 函数计算字符串占用空间大小。

## 子字符串

`substr(x, start, stop)` 从字符串 `x` 中取出从 `start` 到 `stop` 的子串。例如：

```r
> substr("Memory", 1, 4)
[1] "Memo"
```

如果 `x` 是字符串型向量，`substr` 将对每个元素取子字符串：

```r
> substr(c("January", "February", "March", "April"), 1, 3)
[1] "Jan" "Feb" "Mar" "Apr"
```

`substring(x, start)` 可以从字符串 `x` 中取从 start 开始到末尾的字符串。例如：

```r
> substring(c("January", "February"), 3)
[1] "nuary"  "bruary"
```

## 类型转换

用 `as.numeric()` 把内容是数字的字符串转换为数值。例如：

```r
> as.numeric(substr("Jan007", 4, 6))+3
[1] 10
```

`as.numeric` 是向量化方法，所以可以把一个向量的每个元素转换为数值。

`as.character()` 把数值转换为字符串。例如：

```r
> as.character((1:3)*2)
[1] "2" "4" "6"
```

如果变量本身是字符串，不做任何更改。

## sprintf

`sprintf()`可以格式化输出，其用法与 C 语言的 `sprintf()` 类似，不过是向量化的。例如：

```r
> sprintf('file%03d.txt', c(1, 10, 100))
[1] "file001.txt" "file010.txt" "file100.txt"
```

## 字符串拆分

`strsplit()` 把字符串按照指定分隔符拆分。例如:

```r
> strsplit(x, ',', fixed = TRUE)[[1]]
[1] "1" "2" "3"
```

`strsplit()` 的结果是一个列表。

## 字符串替换

`gsub()` 可替换字符串。例如，把分号替换为逗号：

```r
> gsub(';', ',', x, fixed = TRUE)
[1] "1, 3, 5"
```

## 正则表达式

R 中支持 perl 语言格式的正则表达式。`grep()` 和 `grepl()` 函数从字符串中查询某个模式，`sub()` 和 `gsub()` 替换某模式。例如，将多个空格替换为一个空格：

```r
> gsub('[[:space:]]+', ' ', 'a   cat   in a box', perl = TRUE)
[1] "a cat in a box"
```
