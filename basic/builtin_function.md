# R 内置函数

- [R 内置函数](#r-内置函数)
  - [函数列表](#函数列表)
  - [逻辑运算函数](#逻辑运算函数)
  - [序列函数](#序列函数)
    - [seq](#seq)
    - [rep](#rep)
  - [str(a)](#stra)
  - [管理R工作空间的函数](#管理r工作空间的函数)
  - [sink("filename")](#sinkfilename)
  - [source("filename")](#sourcefilename)
  - [图形输出](#图形输出)
  - [数学函数](#数学函数)
    - [三角函数](#三角函数)
    - [分布函数](#分布函数)
    - [统计函数](#统计函数)
  - [R 包](#r-包)
    - [数据管理](#数据管理)
    - [字符串处理](#字符串处理)
  - [all()](#all)
  - [lapply](#lapply)

2020-05-14, 08:33
***

## 函数列表

| 函数                            | 说明                                                                                                       |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| class(a_var)                    | 输出变量类型                                                                                               |
| sum(a_vector)                   | Calculates the sum of all elements of a vecotor                                                            |
| c()                             | 创建向量，将多个值连接起来作为一个向量                                                                     |
| names()                         | 为数据集的 columns 命名                                                                                    |
| help.start()                    | 打开帮助文档首页                                                                                           |
| help("foo"), ?foo               | 查看函数 foo 的帮助                                                                                        |
| help.search("foo"), ??foo       | 以foo 为关键字搜索本地帮助文档                                                                             |
| RSiteSearch("foo")              | 以 foo 为关键词搜索在线文档和邮件列表存档                                                                  |
| apropos("foo", mode="function") | 列出名称中含有 foo的所有可用函数                                                                           |
| data()                          | 获得内置数据集列表                                                                                         |
| getwd()                         | 返回当前的 working directory                                                                               |
| setwd()                         | 设置 workspace                                                                                             |
| leng(x)                         | 返回向量 x 的长度                                                                                          |
| library()                       | 显示库中有哪些包                                                                                           |
| ls()                            | 列出当前空间的变量                                                                                         |
| install.packages()              | 显示一个CRAN镜像站点的列表，选择其中一个镜像站点后，可以看到所有可用包的列表。 install.packages ("glclus") | 下载并安装gclus包 |
| mean()                          | 计算均值                                                                                                   |
| mode                            | 获得向量类型                                                                                               |
| cbind()                         | 把若干列结合成矩阵                                                                                         |
| rbind()                         | row bind缩写，把向量或矩阵按照行合并成一个矩阵                                                             |
| rnorm                           | 生成100个服从N(0,1)分布的随机变量                                                                          |
| colSums()                       | 计算矩阵每列的加和值                                                                                       |
| rowSums()                       | 计算矩阵每行的加和值                                                                                       |
| sd                              | 标准差                                                                                                     |
| typeof                          |                                                                                                            |
| vignette()                      | 列出当前已安装包中所有可用的 vignette文档                                                                  |
| vignette("foo")                 | 为主题 foo 显示指定的 vignette文档                                                                         |

- help.start() 会打开一个浏览器窗口，可在其中查看入门和高级的帮助文档、常见问题集，以及参考材料。
- RSiteSearch() 可在在线帮助手册和 R-Help 邮件列表的讨论存档中搜索指定主题，并在浏览器中返回结果。
- vignette() 返回的 vignette 文档一般是PDF格式的实用介绍性文章。不过并非所有的包都提供 vignette文档。

## 逻辑运算函数

| 函数       | 功能                                  |
| ---------- | ------------------------------------- |
| all        | 参数是否全部为TRUE                    |
| any        | 参数是否有一个为TRUE                  |
| which      | 返回真值对应的下标                    |
| identical  | 两个对象是否完全相同                  |
| all.equal  | 与 identical 类似，但不区分实数与整数 |
| duplicated | 返回每个元素是否为重复值              |
| unique     | 返回去掉重复值的结果                  |

```r
> c(1, NA, 3) > 2
[1] FALSE    NA  TRUE
> v <- c(1, NA, 3)
> v>2
[1] FALSE    NA  TRUE
> all(v > 2)
[1] FALSE
> any(v > 2)
[1] TRUE
> all(NA)
[1] NA
> any(NA)
[1] NA
```

which 示例：

```r
> which(c(FALSE, TRUE, TRUE, FALSE, NA))
[1] 2 3
> which((11:15) > 12)
[1] 3 4 5
```

`identical` 示例：

```r
> v1 <- c(1, 2, 3)
> v2 <- c(1L, 2L, 3L)
> class(v1)
[1] "numeric"
> class(v2)
[1] "integer"
> identical(v1, v2)
[1] FALSE
```

函数all.equal()与identical()类似， 但是在比较数值型时不区分整数型与实数型， 而且相同时返回标量TRUE， 但是不同时会返回一个说明有何不同的字符串。如

```r
> all.equal(c(1, 2, 3), c(1, 2, NA))
[1] "'is.NA' value mismatch: 1 in current 0 in target"
> all.equal(c(1L, 2L, 3L), c(1, 2, 3))
[1] TRUE
```

`duplicated` 示例：

```r
> duplicated(c(1, 2, 1, 3, NA, 4, NA))
[1] FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE
> unique(c(1, 2, 1, 3, NA, 4, NA))
[1]  1  2  3 NA  4
```

## 序列函数

### seq

用于生成等差数列。语法：

```r
seq(from=1, to=10, by=2)
```

说明：

- `from` 指定起始值，默认为 1.
- `to` 指定终止值
- `by` 指定差值

另外：

- `seq(5)` 等价于 `1:6`
- `seq(2, 5)` 等价于 `2:5`

```r
> seq(5)
[1] 1 2 3 4 5
> 1:5
[1] 1 2 3 4 5
> seq(2:5)
[1] 1 2 3 4
> 2:5
[1] 2 3 4 5
> seq(11, 15, by=2)
[1] 11 13 15
> seq(0, 2*pi, length.out = 100) # 生成 0 到 2pi 的等差序列，序列长度为100
```

### rep

`rep()` 用来生成重复数值。语法：

```r
rep(a, b)
```

rep 表示 repeat，将 a 重复 b次，获得一个向量。例如：

- `rep(0, n)`, 初始值为 0 长度为 n 的向量
- `rep(c(1, 3), 2)`，把第一个向量重复3次，得到 c(1, 3, 1, 3)
- `rep(c(1,3), c(2, 4))`，按照一一对应原则重复

```r
> rep(c(1, 3), c(2, 4))
[1] 1 1 3 3 3 3
```

如果希望重复完一个元素之后，再重复另一个元素，可以用 `each=` 选项。例如：

```r
> rep(c(1, 3), each=2)
[1] 1 1 3 3
```

## str(a)

str 表示 structur，用于显示对象结构。a 为任意数据结构。

## 管理R工作空间的函数

| 函数                            | 功能                                          |
| ------------------------------- | --------------------------------------------- |
| getwd()                         | 显示当前的工作目录                            |
| setwd("adirectory")             | 修改当前的工作目录为 adirectory               |
| ls()                            | 列出当前工作空间中的对象                      |
| rm(objectlist)                  | 移除一个或多个对象                            |
| help(options)                   | 显示可用选项的说明                            |
| options()                       | 显示或设置当前选项                            |
| history(#)                      | 显示最近使用过的#个命令（默认25）             |
| savehistory("myfile")           | 保存命令历史到文件myfile中（默认为.Rhistory） |
| loadhistory("myfile")           | 载入一个命令历史文件（默认为 .Rhistory）      |
| save.image("myfile")            | 保存工作空间到文件myfile中（默认为 .RData）   |
| save(objectlist, file="myfile") | 保存指定对象到一个文件                        |
| load("myfile")                  | 读取一个工作空间到当前会话中                  |
| q()                             | 提出R                                         |

`options(digits=3)`
设置

## sink("filename")

将输出重定向到文件 filename 中。
默认，如果文件已存在，则覆盖其内容。
参数

- append=TRUE, 可以将文本追加到文件后。
- split=TRUE, 同时将输出发动到屏幕和输出文件中。

## source("filename")

在当前会话中执行一个脚本。如果文件名不包含路径，R默认此脚本在当前工作目录中。

## 图形输出

| 函数                         | 输出            |
| ---------------------------- | --------------- |
| pdf("filename.pdf")          | PDF文件         |
| win.metafile("filename.wmf") | Windows图元文件 |
| png("filename.png")          | PNG文件         |
| jpeg("filename.jpg")         | JPEG文件        |
| bmp("filename.bmp")          | BMP文件         |
| postscript("filename.ps")    | PostScript文件  |

## 数学函数

| 函数      | 功能               |
| --------- | ------------------ |
| sqrt()    | 平方根             |
| exp()     | 指数               |
| log10()   | 对数               |
| round()   | 取整               |
| floor()   | 向下取整           |
| ceiling() | 向上取整           |
| sin()     | 正弦               |
| cos()     | 余弦               |
| tan()     | 正切               |
| asin()    | 反正切             |
| acos()    | 反余弦             |
| atan      | 反正切             |
| dnorm()   | 标准正态分布密度   |
| pnorm()   | 标准正态分布函数   |
| qnorm     | 标准正态分布分位数 |

`round()` 用于舍入：

```r
> round(1.1234, 2)
[1] 1.12
> round(-1.98765, 2)
[1] -1.99
```

`floor` 和 `ceiling` 用于取整：

```r
> floor(1.1234)
[1] 1
> floor(-1.12)
[1] -2
> ceiling(1.123)
[1] 2
> ceiling(-1.234)
[1] -1
```

### 三角函数

```r
> pi
[1] 3.141593
> sin(pi/6)
[1] 0.5
> cos(pi/6)
[1] 0.8660254
> sqrt(3)/2
[1] 0.8660254
> tan(pi/6)
[1] 0.5773503
```

反三角函数，结果为弧度值：

```r
> asin(0.5) # 反正弦
[1] 0.5235988
> acos(sqrt(3)/2) # 反余弦
[1] 0.5235988
> atan(sqrt(3)/3) # 反正切
[1] 0.5235988
```

### 分布函数

`dnorm(x)` 表示标准正态分布密度函数 $\varPhi(x)=\frac{1}{\sqrt{2\pi}}e^{-\frac{1}{2}x^2}$。

`pnorm(x)` 表示标准正态分布函数 $\Phi(x)=\int_{-\infin}^x\varPhi(t)dt$.

`qnorm(y)` 表示标准正态分布分位函数 $\Phi^{-1}(x)$

### 统计函数

| 函数    | 功能           |
| ------- | -------------- |
| sum     | 求和           |
| mean    | 均值           |
| var     | 方差           |
| sd      | 标准差         |
| min     | 最小值         |
| max     | 最大值         |
| range   | 最小值和最大值 |
| prod    | 所有元素乘积   |
| cumsum  | 累积加和       |
| cumprod | 累积乘积       |

```r
> cumsum(1:5)
[1]  1  3  6 10 15
> cumprod(1:5)
[1]   1   2   6  24 120
> prod(1:5)
[1] 120
```

## R 包

### 数据管理

vector：向量 numeric：数值型向量 logical：逻辑型向量character；字符型向量 list：列表 data.frame：数据框c：连接为向量或列表 length：求长度 subset：求子集seq，from:to，sequence：等差序列rep：重复 NA：缺失值 NULL：空对象sort，order，unique，rev：排序unlist：展平列表attr，attributes：对象属性 mode，typeof：对象存储模式与类型names：对象的名字属性

### 字符串处理

character：字符型向量 nchar：字符数 substr：取子串format，formatC：把对象用格式转换为字符串
paste，strsplit：连接或拆分
charmatch，pmatch：字符串匹配grep，sub，gsub：模式匹配与替换

复数
complex，Re，Im，Mod，Arg，Conj：复数函数

因子
factor：因子 codes：因子的编码 levels：因子的各水平的名字nlevels：因子的水平个数 cut：把数值型对象分区间转换为因子table：交叉频数表 split：按因子分组aggregate：计算各数据子集的概括统计量tapply：对“不规则”数组应用函数

## all()

对一系列的逻辑向量，是否都为 true。

## lapply

rep
语法：

```r
rep(x, …)
rep.int(x, times)
rep.len(x, length.out)
```
