# 绘制函数曲线

- [绘制函数曲线](#绘制函数曲线)
  - [简介](#简介)

2020-08-31, 15:53
@jiaweiM
***

## 简介

计算并绘制函数的连续曲线。这样就可以很容易在已有图上叠加函数。该函数沿着 x 轴等间隔的调用该函数，然后将线将这些点连起来。

```r
geom_function(
  mapping = NULL,
  data = NULL,
  stat = "function",
  position = "identity",
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

stat_function(
  mapping = NULL,
  data = NULL,
  geom = "function",
  position = "identity",
  ...,
  fun,
  xlim = NULL,
  n = 101,
  args = list(),
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)
```

参数说明：

1. mapping

由 `aes()` 或 `aes_()` 创建的美学映射列表。如果指定该映射，并且 `inherit.aes = TRUE`（默认），则和顶层的默认映射合并。

2. data

`stat_function()` 忽略该参数。

3. stat

以字符串的形式指定该层数据的统计转换。

4. position

位置调整，可以是字符串，也可以是对应的位置函数。

5. ...

传递给 `layer()` 的其它参数。
