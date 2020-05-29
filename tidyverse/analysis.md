# 数据处理

- [数据处理](#数据处理)
  - [简介](#简介)
  - [mutate](#mutate)

2020-05-29, 12:55
***

## 简介

数据的基本结构如下所示：

![data](images/2020-05-29-12-50-12.png)

tidy 的基本思想：

- 数据结构：数据框
- 数据框的列表示一个变量，行表示一个样本
- 函数处理时，输入和数据均为数据库结构

下面介绍 tidy 中的数据处理神器 `dplyr` 包。其中主要包含以下 7 个函数：

- `mutate()`, `select()`, `filter()`
- `summarise()`, `group_by()`, `arrange()`
- `left_join()`, `right_join()`, `full_join()`

## mutate


