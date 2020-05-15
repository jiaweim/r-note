# 概述

- [概述](#%e6%a6%82%e8%bf%b0)
  - [基本概念](#%e5%9f%ba%e6%9c%ac%e6%a6%82%e5%bf%b5)
    - [Workspace](#workspace)
    - [图形用户界面](#%e5%9b%be%e5%bd%a2%e7%94%a8%e6%88%b7%e7%95%8c%e9%9d%a2)
  - [R 运算符](#r-%e8%bf%90%e7%ae%97%e7%ac%a6)
    - [数序运算符](#%e6%95%b0%e5%ba%8f%e8%bf%90%e7%ae%97%e7%ac%a6)
    - [逻辑运算符](#%e9%80%bb%e8%be%91%e8%bf%90%e7%ae%97%e7%ac%a6)
  - [数据类型](#%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b)
  - [赋值和下划线](#%e8%b5%8b%e5%80%bc%e5%92%8c%e4%b8%8b%e5%88%92%e7%ba%bf)

2020-05-12, 20:16
***

## 基本概念

### Workspace

Workspace 是当前 R 的工作环境，包含用户自定义的对象，如向量、数据库、函数等。在一个 R 会话结束时，用户可以保存当前的用户空间镜像，下次启动 R 时自动加载镜像。

### 图形用户界面

除了内置的 R console，RStudio 是使用最广泛的 R 代码编辑器，推荐是还有。

## R 运算符

### 数序运算符

|Operator|Description|
|---|---|
|+|addition|
|-|subtraction|
|*|multiplication|
|/|division|
|^ or **|exponentiation|

### 逻辑运算符

|Operator|Description|
|---|---|
|>|greater than|
|>=|greater than or equal to|
|==|exactly equal to|
|!=|not equal to|

## 数据类型

R 支持多种数据类型，包括标量、向量（数值、字符、逻辑）、矩阵、数据框以及列表等。



## 赋值和下划线

R 的赋值运算符为 `<-`。例如：

```r
e <- m*c^2
```

也可以反过来：

