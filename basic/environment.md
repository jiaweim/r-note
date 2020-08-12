# 工作空间

- [工作空间](#工作空间)
  - [简介](#简介)
  - [查看工作空间 - ls](#查看工作空间---ls)
  - [ls.str](#lsstr)
  - [清理工作空间 - remove](#清理工作空间---remove)

2020-05-14, 11:39
***

## 简介

R 是用于数据处理、计算和可视化的软件工具包。包含大量功能：

- 数据分析和存储
- 用于数据（特别是矩阵）的一组运算符
- 大量用于数据分析的工具集合
- 用于数据分析和显示的可视化功能
- 一种高级且简单的编程语言（S语言）

R 将命令行中定义的变量都保存在工作空间， 在退出R时可以选择是否保存工作空间。 这是 R 与其他如C、Java这样的语言的区别之一。

## 查看工作空间 - ls

`ls()` 函数用于查看工作空间里的对象，只列出对象名。

`ls` 和 `objects` 函数返回一个字符串向量，给出指定环境中对象的名称。

- 在顶层无参数调用时，`ls` 显示用户自定义的数据集和函数。
- 在函数内部无参数调用时，`ls` 返回函数的本地变量名称，和 `browser` 结合使用更方便。

例如：

```r
> x <- c(1, 6, 2)
> y <- c(1, 4, 3)
> ls()
[1] "x" "y"
```

如果工作空间里没有对象：

```r
> ls()
character(0)
```

语法：

```r
ls(name, pos = -1L, envir = as.environment(pos),
   all.names = FALSE, pattern, sorted = TRUE)

objects(name, pos= -1L, envir = as.environment(pos),
        all.names = FALSE, pattern, sorted = TRUE)
```

参数说明：

1. name

用于指定环境。默认为当前环境。可以为多种类型：

- integer, 环境在 `search` 列表中的位置。
- 字符串，环境在 `search` 列表中的名称

`pos` 和 `envir` 参数为 `name` 的替代参数，基于兼容性保留。

2. all.names

布尔值，如果为 `TRUE`，则返回所有对象名称；如果为 `FALSE`,以 `.` 开头的名称忽略。

3. pattern

可选的正则表达式。只返回匹配 `pattern` 的名称。可以使用 `glob2rx` 将通配符模式转换为正则表达式。

例如，显示以某个字母开头的对象：

```r
ls(pat = "^m")
```

4. sorted

是否对返回的结果排序。

例如：

```r
# NOT RUN {
.Ob <- 1
ls(pattern = "O")
ls(pattern= "O", all.names = TRUE)    # also shows ".[foo]"

# shows an empty list because inside myfunc no variables are defined
myfunc <- function() {ls()}
myfunc()

# define a local variable inside myfunc
myfunc <- function() {y <- 1; ls()}
myfunc()                # shows "y"
# }
```

## ls.str

`ls.str` 和 `lsf.str` 是 [ls](#查看工作空间---ls) 的变体，对 `ls` 返回的对象应用 `str()` 函数。可以获得对象的详细信息。

语法：

```r
ls.str(pos = -1, name, envir, all.names = FALSE,
       pattern, mode = "any")
lsf.str(pos = -1, envir, …)

# S3 method for ls_str
print(x, max.level = 1, give.attr = FALSE, …,
      digits = max(1, getOption("str")$digits.d))
```

参数：

1. pos

指定 `search` 中的位置，`-1` 表示当前环境。

`name` 和 `envir` 参数都是 `name` 的替代参数，基于兼容性考虑而保留。

2. all.names

是否显示以 `.` 开头的名称，默认为 TRUE.

3. pattern

4. max.level

指定最大嵌套级别，默认为 `1`，即只显示第一个嵌套级别。

## 清理工作空间 - remove

随着在命令行中使用 R，工作空间里的变量会越来越多，这样出现重名的概率越来越大，此时可以清理一些不用的变量。

`remove` 和 `rm` 用于从工作空间中移除对象。

语法：

```r
remove(…, list = character(), pos = -1,
       envir = as.environment(pos), inherits = FALSE)
rm    (…, list = character(), pos = -1,
       envir = as.environment(pos), inherits = FALSE)
```

参数：

1. ...

待移除对象，可以为字段名称（无引号）或字符串名称（带引号）。

2. list

3. pos

4. envir

如果 `envir` 为 NULL，则搜索当前工作空间。

5. inherits

如果 `inherits` 为 TRUE，则同时检索提供目录的父目录，直到找到对应名称的变量。如果未找到对应变量，输出警告信息。

例如：

- 删除对象 `x`

```r
rm(x)
```

- 删除对象 `x` 和 `y`

```r
rm(x, y)
```

- 删除内存中所有对象

```r
rm(list=ls())
```

- 删除以 `m` 开头的对象

```r
rm(list=ls(pat="^m"))
```

要避免工作空间杂乱，最好的办法还是所有的运算都写到自定义函数中。 自定义函数中定义的变量都是临时的，不会保存到工作空间中。 这样，仅需要时才把变量值在命令行定义， 这样的变量一般是读入的数据或自定义的函数 （自定义函数也保存在工作空间中）。

可以定义如下的sandbox()函数：

sandbox <- function(){
  cat('沙盘：接连的空行回车可以退出。\n')
  browser()
}
运行sandbox()函数，将出现如下的browser命令行：

沙盘：接连的空行回车可以退出。
Called from: sandbox()
Browse[1]> 
提示符变成了“Browser[n]”，其中n代表层次序号。 在这样的browser命令行中随意定义变量， 定义的变量不会保存到工作空间中。 用“Q”命令可以退出这个沙盘环境， 接连回车也可以退出。
