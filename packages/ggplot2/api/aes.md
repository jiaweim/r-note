# aes

@since 2026-09-16
@author Jiawei Mao
***

`aes()` 用于构建美学映射（Aesthetic mappings）。

美学映射描述了如何将数据中的变量映射到几何对象（geoms）的视觉属性（即美学特征）上。美学映射既可以在 `ggplot()` 函数中进行全局设置，也可以在各个独立的图层（layers）中单独设置。

```R
aes(x, y, ...)
```

## 参数（Arguments）

- `x`, `y`, `...` `<data-masking>`

由“图形属性 = 变量”组成的名称-值对列表，用于描述图层数据中的哪些变量应映射到对应的 geom（几何对象）或 stat（统计变换）所使用的图形属性上。

表达式中的 `variable`（变量）会在图层数据的上下文中进行求值，因此无需引用原始数据集（即，应使用 `ggplot(df, aes(variable))` 而不是 `ggplot(df, aes(df$variable))`）。由于 `x` 和 `y` 图形属性最为常用，其名称通常可以省略；但其他所有图形属性都必须显式指定名称。

## 返回值（Value）

一个 S7 对象，表示一个具有 `mapping` 类的列表。该列表的组件要么是准表达式（quosures），要么是常量。

## 详细说明（Details）

该函数还会对图形属性名称进行标准化处理：将 `color` 转换为 `colour`（包括在子字符串中的情况，例如将 `point_color` 转换为 `point_colour`），并将旧式的 R 语言名称转换为 ggplot 的名称（例如将 `pch` 转换为 `shape`，将 `cex` 转换为 `size`）。

**注意事项（Note）**

使用 `I()` 函数创建 `'AsIs'` 类的对象会导致标度（scales）忽略该变量，并假定被包裹的变量是提供给 `grid` 包的直接输入。请注意，在某些统计变换（stats）或位置调整中，变量有时会被合并，这可能会导致 `'AsIs'` 变量产生意想不到的结果。

**准引用（Quasiquotation）**

`aes()` 是一个引用函数（quoting function）。这意味着它的输入会被引用，以便在数据的上下文中进行求值。这使得直接使用数据框中的变量变得非常方便，因为你可以直接写出变量名。但另一方面，如果你想在编程中动态使用 `aes()`，就必须使用准引用（quasiquotation）。如需了解这些技术的更多信息，请参阅 tidy evaluation 相关教程，例如 `dplyr` 编程指南（vignette）。

**另请参阅（See also）**

`vars()`：另一个专为分面（faceting）规范设计的引用函数。

运行 `vignette("ggplot2-specs")` 可以查看其他可修改的图形属性的概述。

延迟评估（Delayed evaluation）：用于处理计算得出的变量。

其他图形属性相关文档：`aes_colour_fill_alpha`，`aes_group_order`，`aes_linetype_size_shape`，`aes_position`。

## 参考

- https://ggplot2.tidyverse.org/reference/aes.html