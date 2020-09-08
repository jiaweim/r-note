# filter

- [filter](#filter)
  - [简介](#简介)
  - [过滤函数](#过滤函数)

2020-09-07, 20:27
@jiawei
***

## 简介

`filter` 根据值过滤 rows。

数据框的任何子集仍为数据框，即使只有一行而且都是数值也是如此。行子集可以用行下标选取，例如 `d.class[8:12,]`。函数 `head()` 取出数据框的前面若干行，`tail()` 取出数据框的最后若干行。

dplyr 的 `filter()` 函数可以按条件选出符合条件的行组成的子集。比如，把成绩高于 90 分的同学筛出来：

```r
> df %>% filter(score >= 90)
   name    type score
1 Alice    math  90.5
2   Bob english  92.2
3   Bob    math  90.8
```

也可以同时限定多个条件，如英语成绩高于 90 分：

```r
> df %>% filter(type=="english", score >= 90)
  name    type score
1  Bob english  92.2
```

这些操作都是返回一个新数据框，不影响原数据框。

筛选 class 数据集中不大于 13 岁的女生：

```r
> d.class %>% filter(sex=='F', age<=13) %>% knitr::kable()

|name  |sex | age| height| weight|
|:-----|:---|---:|------:|------:|
|Alice |F   |  13|   56.5|   84.0|
|Becka |F   |  13|   65.3|   98.0|
|Karen |F   |  12|   56.3|   77.0|
|Kathy |F   |  12|   59.8|   84.5|
|Sandy |F   |  11|   51.3|   50.5|
```

## 过滤函数

在构造过滤表达式时，可以使用多种函数和运算符：

