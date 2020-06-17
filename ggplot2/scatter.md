# 散点图

- [散点图](#散点图)
  - [R 作图](#r-作图)
  - [ggplot](#ggplot)
  - [拟合线](#拟合线)

2020-06-16, 21:10
***

## R 作图

使用 `plot()` 绘制散点图，例如：

```r
plot(mtcars$wt, mtcars$mpg)
```

![scatter](images/2020-06-16-21-16-22.png)

## ggplot

```r
library(ggplot2)

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()
```

![scatter](images/2020-06-16-21-17-46.png)

`ggplot()` 创建一个 plot 对象，`geom_point()` 在 plot 上添加散点图层。

`ggplot()` 经典的用法是，将 frame (`mtcars`) 传递给 `ggplot()`，指定 `x` 和 `y` 的数据，如果希望将两个单独的向量作为 x 和 y 值，可以设置 `data=NULL`，不过这样只能使用 `ggplot()` 的部分功能。例如：

```r
ggplot(data = NULL, aes(x = mtcars$wt, y = mtcars$mpg)) +
  geom_point()
```

## 拟合线

`geom_smooth`

参数说明：

- `size` 指定线的粗细（单位毫米）
- `se=FALSE` 表示关闭置信区间显示
- `alpha=` 设置透明度，0 到 1 之间，值越小越透明

