# 环境

2024-09-05⭐
@author Jiawei Mao
***

## 简介

R 是用于数据处理、计算和可视化的软件工具包。包含大量功能：

- 数据分析和存储
- 用于数据（特别是矩阵）的一组运算符
- 大量用于数据分析的工具集合
- 用于数据分析和显示的可视化功能
- 一种高级且简单的编程语言（S语言）

R 将命令行中定义的变量都保存在工作空间， 在退出R时可以选择是否保存工作空间。 这是 R 与其他如C、Java 这样的语言的区别之一。

R 的环境类似文件系统，采用树形结构组织环境，每个环境都有一个 parent-环境。

使用 pryr 包的 `parenvs` 函数可以查看 R 的环境系统。`parenvs(all = TRUE)` 返回 R 会话正在使用的环境列表。实际输出取决于当前加载的包：

```R
> library("pryr")
> parenvs(all = TRUE)
   label                             name               
1  <environment: R_GlobalEnv>        ""                 
2  <environment: package:pryr>       "package:pryr"     
3  <environment: package:devtools>   "package:devtools" 
4  <environment: package:usethis>    "package:usethis"  
5  <environment: 0x000002897de5e450> "tools:rstudio"    
6  <environment: package:stats>      "package:stats"    
7  <environment: package:graphics>   "package:graphics" 
8  <environment: package:grDevices>  "package:grDevices"
9  <environment: package:datasets>   "package:datasets" 
10 <environment: 0x000002897e537818> "renv:shims"       
11 <environment: package:utils>      "package:utils"    
12 <environment: package:methods>    "package:methods"  
13 <environment: 0x000002897a692ea8> "Autoloads"        
14 <environment: base>               ""                 
15 <environment: R_EmptyEnv>         ""    
```

`R_EmptyEnv` 是最高级的环境，是唯一没有 parent-环境的环境，可以看作树根。

## 查看环境

R 提供了一些辅助函数来查看 environment-tree。`as.environment()` 以环境名为参数，返回相应的环境：

```R
> as.environment("package:stats")
<environment: package:stats>
attr(,"name")
[1] "package:stats"
attr(,"path")
[1] "C:/Program Files/R/R-4.4.1/library/stats"
```

这里列出了该环境的属性，包括名称和路径。

三个特殊的环境有单独的访问函数：

- `globalenv()`: 最底层环境
- `baseenv()`
- `emptyenv()`：最高层环境

```R
> globalenv()
<environment: R_GlobalEnv>

> baseenv()
<environment: base>

> emptyenv()
<environment: R_EmptyEnv>
```

- 用 `parent.env` 查看指定环境的 parent-环境

```R
> parent.env(globalenv())
<environment: package:pryr>
attr(,"name")
[1] "package:pryr"
attr(,"path")
[1] "D:/repo/rstudio_demo/hello_world/renv/library/windows/R-4.4/x86_64-w64-mingw32/pryr"
```

emptyenv 是唯一没有 parent-环境的环境：

```R
> parent.env(emptyenv())
Error in parent.env(emptyenv()) : the empty environment has no parent
```

使用 `ls` 或 `ls.str` 查看环境中的对象

- `ls` 只列出对象名称
- `lr.str` 列出名称和对象的结构

```R
> ls(emptyenv())
character(0)

> ls(globalenv())
 [1] "a"        "abalone"  "b"        "c"        "comp"     "deal"     "deck"    
 [8] "deck2"    "deck3"    "deck4"    "deck5"    "df"       "dice"     "die"     
[15] "facecard" "five"     "gender"   "hand"     "int"      "list1"    "logic"   
[22] "lst"      "m"        "mil"      "new"      "now"      "poker"    "random"  
[29] "roll"     "roll2"    "rolls"    "shuffle"  "text"     "vec"      "w"       
[36] "x"        "x2"       "x3"       "y"        "z"  
```

empty-环境是空的，base-环境包含大量对象，global-环境包含我们自己创建的对象。

RStudio 的 Environment 窗口列出 global 环境的所有对象。

可以使用 `$` 访问特定环境中的对象。例如，访问 global-环境中的 deck 对象：

```R
> head(globalenv()$deck, 3)
   face   suit value
1  king spades    13
2 queen spades    12
3  jack spades    11
```

## assign

`assign()` 函数可以将对象保存到特定环境。`assign` 需要三个参数：

1. 对象名称：字符串
2. 对象
3. 环境

例如：

```R
> assign("new", "Hello Global", envir = globalenv())
> globalenv()$new
[1] "Hello Global"
```

`assign()` 的工作机制类似于 `<-`。如果指定环境中已有同名对象，则 `assign()` 将覆盖原有对象。

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

## attach

## 活跃环境

任何时候，R 只与单个环境交互，称为活跃环境（active environment）。R 将新对象存储到活跃环境，使用该环境作为查找对象的起点。活跃环境通常为 global-环境，不过在运行函数时可能会发生变化。

- 使用 `environment()` 查看当前活跃环境

```R
> environment()
<environment: R_GlobalEnv>
```

global-环境比较特殊，它与控制台交互，在控制台创建的所有对象都自动保存到 global-环境。

在控制台调用对象，R 会首先在 global-环境查找该对象，如果没找到，R 会采用特定规则去其他环境找。

## 查找规则

R 使用一套特殊的规则来查找对象，称为 R 作用域规则（scoping rules）：

1. 在当前活跃环境查找对象；
2. 在控制台输入命令时，活跃环境为 global-环境，因此首先在 global-环境中查找对象；
3. 如果在当前活跃环境没找到对象，则继续在 parent-环境中找，依此类推，直到最终的树根：empty-环境。

如果一直到 empty-环境都没找到所需对象，R 会抛出错误。

> [!NOTE]
>
> 在 R 中函数也是一种对象，其查找规则与其它对象一样。

## 赋值

为对象赋值时，R 在活跃环境中以对象名称保存该值。如果活跃环境中已有同名对象，则覆盖。

例如，global-环境已有名为 `new` 的对象：

```R
> new
[1] "Hello Global"
```

然后以名称 `new` 重新保存一个对象到 global-环境：

```R
> new <- "Hello Active"
> new
[1] "Hello Active"
```

显然，原来的对象值被覆盖了。

但是，这会带来一个问题。在函数中会使用临时对象来辅助计算，如果这些临时对象恰好与 global-环境中的对象重名，就会覆盖现有对象。函数作者无法预测活跃环境中已有哪些名称，为了避免这种风险，每次 运行函数，R 都会创建一个新的环境。

## 执行函数

在 R 运行函数时，将新创建的环境作为 active-环境，函数执行完后，回到调用函数所在的环境，并带来函数执行的结果。这类环境称为**运行时环境**（runtime environment），因为它们是在运行时创建来执行函数。

先定义一个函数辅助研究函数的运行时环境：

```R
show_env <- function() {
  list(
    ran.in = environment(),
    parent = parent.env(environment()),
    objects = ls.str(environment())
  )
}
```

`show_env()` 是一个函数，因此调用它时，R 会创建一个 runtime 环境，`show_env()` 会保存 runtime 环境的名称、其 parent 环境以及 runtime 环境中包含的对象：

```R
> show_env()
$ran.in
<environment: 0x00000289103ab188>

$parent
<environment: R_GlobalEnv>

$objects
```

结果显示，R 创建了一个名为 `0x00000289103ab188` 的新环境来执行 `show_env()`。该环境不包含对象，其 parent 环境为 global 环境。

再次运行 `show_env()`：

```R
> show_env()
$ran.in
<environment: 0x0000028910491e80>

$parent
<environment: R_GlobalEnv>

$objects
```

这次又创建了一个名为 `0x0000028910491e80` 的环境。

下面来讨论一下 runtime 环境的 parent 环境。

函数 runtime 环境的 parent 环境为创建函数所在的环境。这个环境在函数的生命周期中起着重要角色，因为函数的所有 runtime 环境都将它作为 parent 环境。这个环境称之为**原点环境**（origin environment）。

使用 `environment()` 查看函数的原点环境：

```R
> environment(show_env)
<environment: R_GlobalEnv>
```

因为是在命令行中创建的 `show_env()` 函数，所以其 origin 环境为 global 环境。

`parenvs` 的 origin 环境为 **pryr** 包：

```R
> environment(parenvs)
<environment: namespace:pryr>
```

换言之，runtime 环境的 parent 环境不一定是 global 环境，而是最初创建函数的环境。

最后来看看 runtime 环境中的对象。目前 `show_env()` 的 runtime 环境不包含任何对象，下面在其中创建一些对象：

```R
show_env <- function() {
  a <- 1
  b <- 2
  c <- 3
  list(
    ran.in = environment(),
    parent = parent.env(environment()),
    objects = ls.str(environment())
  )
}
```

再运行 `show_env()`，R 会将 a, b, c 对象保存在 runtime 环境中：

```r
> show_env()
$ran.in
<environment: 0x000002890fcf71b8>

$parent
<environment: R_GlobalEnv>

$objects
a :  num 1
b :  num 2
c :  num 3
```

除了函数中的临时变量，函数**参数**也保存在 runtime 环境中。

如果函数有参数，R 会将每个参数复制到 runtime 环境。

```R
foo <- "take me to your runtime"

show_env <- function(x = foo) {
  list(
    ran.in = environment(),
    parent = parent.env(environment()),
    objects = ls.str(environment())
  )
}
```

```R
> show_env()
$ran.in
<environment: 0x00000289112f3868>

$parent
<environment: R_GlobalEnv>

$objects
x :  chr "take me to your runtime"
```

**总结：**

- 在调用函数前，R 处于 active 环境，我们将其称为调用环境（calling），即在这里调用函数；
- 调用函数，R 设置一个新的 runtime 环境，该 runtime 环境的 parent 环境是函数的 origin 环境；
  - R 将函数参数复制到 runtime 环境，并将该 runtime 环境设为新的 active 环境
  - 运行函数代码，代码创建的任何对象保存到当前 active 环境，即 runtime 环境
  - 如果代码调用任何对象，R 采用 scoping 规则搜索，即先搜索 runtime 环境，然后搜索其 parent 环境，即 origin 环境，依此类推。但是 **calling 环境不能在搜索路径上**。
  - 函数通常只调用其参数，而参数在 active runtime 环境中
- 完成函数执行，将 active 环境切换回 calling 环境。

