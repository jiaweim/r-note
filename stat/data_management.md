# 数据管理

## 排序

排序函数：

- sort(), 对向量从小到大排序
- rank(), 返回向量中每个数值对应的秩；
- order(), 返回向量中元素排序后的位置；
- dplyr 包中的 arrange()  函数针对数据框，返回基于某列排序后的数据框，方便多重排序。

## 数据集合并

### 添加列

merge() 或 cbind() 横向合并两个数据集。使用 cbind() 合并对象必须行数相同。

### 添加行

rbind()

要求两个数据框拥有相同的变量，熟悉不必相同。

rbind() 通常用来添加样本。

## 缺失值

R 中缺失值用 NA（Not Available）表示。

不可能出现的值用 NaN (Not a Number) 表示。

用函数 `is.na()` 检测缺失值。该函数返回一个相同大小的对象，缺失值对应位置为 TRUE，其它为 FALSE。

在数据处理过程中，大多数函数都存在参数 `na.rm=TRUE` 选项用于移除缺失值。

函数 `na.omit()` 移除所有含有缺失值的行。