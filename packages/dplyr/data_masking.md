# Data masking

- [Data masking](#data-masking)
  - [简介](#简介)
  - [数据变量和环境变量](#数据变量和环境变量)
  - [间接性](#间接性)

2020-09-07, 18:45
@jiawei
***

## 简介

数据屏蔽（data masking）使得数据处理更快，因为它需要更少的键入内容。大多数的 R 基础函数需要通过 `$` 引用变量，需要反复的使用数据框名称，例如：

```r
starwars[starwars$homeworld == "Naboo" & starwars$species == "Human", ,]
```

而使用 dplyr 代码要简洁许多：

```r
starwars %>% filter(homeworld == "Naboo", species == "Human")
```

## 数据变量和环境变量

数据屏蔽的关键思想是扩展了变量的概念：

- 环境变量（env-variable）指常规意义上的编程变量，一般用 `<-` 创建。
- 数据变量（data-variable）指数据框中的统计变量。一般来自于数据文件，或通过已有变量创建而来。

如下所示：

```r
df <- data.frame(x = runif(3), y = runif(3))
df$x
#> [1] 0.08075014 0.83433304 0.60076089
```

这里，`df` 就是编程变量，`x` 和 `y` 为数据变量。然后可以通过 `df$x` 从数据框类型的编程变量中提取数据变量。

## 间接性


