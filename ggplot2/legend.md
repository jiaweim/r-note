# Legend

- [Legend](#legend)
  - [简介](#简介)
  - [Layout](#layout)
  - [标题](#标题)
    - [使用 scale](#使用-scale)

2020-09-07, 21:10
***

## 简介

从某种程度上来说，图例（legend）比坐标轴更复杂，因为：

1. 图例可以显示多个图层的多种美学特征（如颜色、形状）。
2. 坐标轴总是出现在同一个地方，而图例可以出现在多个地方。
3. 图例有许多可以调节的细节：水平还是垂直显示？多少列？多大？

## Layout

图例的对齐方式和位置由 `theme()` 函数的 `legend.position` 参数设置。可选值有：

|legend.position|说明|
|---|---|
|right|
|left|
|top|
|bottom|
|none|无legend|

## 标题

修改 legend 标题的方法有两种。

- 在 `scale` 中设置标题和标签。
- 修改数据框

### 使用 scale

legend 可以和 fill, colours, linetype, shape 等美学特征关联。


