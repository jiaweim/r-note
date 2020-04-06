# 包

## 函数

|函数|功能|
|---|---|
|install.packages()|安装包。不加参数，显示CRAN镜像站点站点，加包名称，直接下载安装包|
|installed.packages()|列出安装的包|
|update.packages()|更新已安装的包|
|library()|载入包|
|help(package="package_name")|输出某个包的简短描述，以及包中的函数名称和数据集名称的列表|

## 简介

R 包为 R 函数集合。

载入包
R 包在使用前，需要载入当前的 R 环境。载入包命令：
```r
library("package_name", lib.loc = "path to library")
```