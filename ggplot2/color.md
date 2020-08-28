# Color

## 简介

ggplot2 的默认颜色区分度不是很好，对色盲也不是很友好，因此自定义颜色很重要。

## 样例数据

```r
# Two variables
df <- read.table(header=TRUE, text='
 cond yval
    A 2
    B 2.5
    C 1.6
')

# Three variables
df2 <- read.table(header=TRUE, text='
 cond1 cond2 yval
    A      I 2
    A      J 2.5
    A      K 1.6
    B      I 2.2
    B      J 2.4
    B      K 1.2
    C      I 1.7
    C      J 2.3
    C      K 1.9
')
```

## 指定颜色

线条和点的颜色可以直接使用 `color="red"` 指定。bar 等填充对象的颜色可以使用 `fill="red"` 格式指定。

如果要使用基本颜色之外的颜色，使用十六进制颜色代码最为方便，例如 "#FF6699"。

- 默认黑色

```r
library(ggplot2)
library(readr)

d1 <- read_table2("cond yval
    A 2
    B 2.5
    C 1.6", col_names = TRUE)


# default: dark bars
ggplot(d1, aes(x = cond, y = yval)) +
  geom_bar(stat = "identity")
```

![bar](images/2020-08-28-09-36-39.png)

- 指定红色边框

```r
ggplot(d1, aes(x = cond, y = yval)) +
  geom_bar(stat = "identity", colour = "#FF9999")
```

![bar](images/2020-08-28-09-50-37.png)

- 指定填充红色、边框黑色

```r
ggplot(d1, aes(x = cond, y = yval)) +
  geom_bar(stat = "identity", fill = "#FF9999", colour = "black")
```

![bar](images/2020-08-28-09-54-44.png)

- 默认黑线黑点
  
```r
ggplot(d1, aes(x = cond, y = yval)) +
  geom_line(aes(group = 1)) +
  geom_point(size = 3)
```

![bar](images/2020-08-28-09-57-16.png)

- 蓝线红点

```r
ggplot(d1, aes(x = cond, y = yval)) +
  geom_line(aes(group = 1), colour = "#000099") + # Blue lines
  geom_point(size = 3, colour = "#CC0000") # Red dots
```

![bar](images/2020-08-28-09-59-41.png)

## 自定义颜色

