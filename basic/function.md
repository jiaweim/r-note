# R 内置函数

- [R 内置函数](#r-%e5%86%85%e7%bd%ae%e5%87%bd%e6%95%b0)
  - [函数列表](#%e5%87%bd%e6%95%b0%e5%88%97%e8%a1%a8)
  - [all](#all)
  - [any](#any)
  - [R Base](#r-base)
  - [R Utils](#r-utils)
    - [ls.str](#lsstr)
  - [rep](#rep)
  - [seq(from=1, to=10, by=2)](#seqfrom1-to10-by2)
  - [str(a)](#stra)
  - [管理R工作空间的函数](#%e7%ae%a1%e7%90%86r%e5%b7%a5%e4%bd%9c%e7%a9%ba%e9%97%b4%e7%9a%84%e5%87%bd%e6%95%b0)
  - [sink("filename")](#sink%22filename%22)
  - [source("filename")](#source%22filename%22)
  - [图形输出](#%e5%9b%be%e5%bd%a2%e8%be%93%e5%87%ba)
  - [数学函数](#%e6%95%b0%e5%ad%a6%e5%87%bd%e6%95%b0)
  - [R 包](#r-%e5%8c%85)
    - [数据管理](#%e6%95%b0%e6%8d%ae%e7%ae%a1%e7%90%86)
    - [字符串处理](#%e5%ad%97%e7%ac%a6%e4%b8%b2%e5%a4%84%e7%90%86)
  - [all()](#all-1)
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

## all

参数是否全部为TRUE。

## any

参数是否有一个为TRUE。

## R Base

## R Utils

### ls.str

`ls.str` 和 `lsf.str` 是 [ls](#ls) 的变体，对 `ls` 返回的名称应用 `str()` 函数。

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

## rep

rep(a, b)
rep 表示 repeat，将 a 重复 b次，获得一个向量。

each 指定每个数分别重复的次数
rep(c(5, 12, 13), each=2)
// 5 5 12 12 13 13

## seq(from=1, to=10, by=2)

生成等差数列。

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
| floor()   | 向上取整           |
| ceiling() | 向下取整           |
| sin()     | 正弦               |
| cos()     | 余弦               |
| tan()     | 正切               |
| asin()    | 反正切             |
| acos()    | 反余弦             |
| atan      | 反正切             |
| dnorm()   | 标准正态分布密度   |
| pnorm()   | 标准正态分布函数   |
| qnorm     | 标准正态分布分位数 |

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
