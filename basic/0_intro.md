# 概述

- [概述](#概述)
  - [基本概念](#基本概念)
    - [Workspace](#workspace)
    - [图形用户界面](#图形用户界面)
  - [R 运算符](#r-运算符)
    - [数序运算符](#数序运算符)
    - [逻辑运算符](#逻辑运算符)
  - [数据类型](#数据类型)
  - [赋值和下划线](#赋值和下划线)

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
