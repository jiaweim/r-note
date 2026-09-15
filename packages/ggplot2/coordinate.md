# 坐标系

@since 2026-09-15
@author Jiawei Mao
***
## 简介

坐标系决定 `x` 和 `y` 美学属性（aesthetics）如何结合，从而确定图形中元素的位置。默认的坐标系是笛卡尔坐标系（`coord_cartesian()`），可以通过 `coord_map()`、`coord_fixed()`、`coord_flip()` 和 `coord_transform()` 进行微调，也可以使用 `coord_polar()` 将其替换。

- **`coord_cartesian()`**：笛卡尔坐标系
- **`coord_fixed()`**：具有固定“纵横比”的笛卡尔坐标系
- **`coord_map()`**：地图投影
- **`coord_polar()`**：极坐标系
- **`coord_transform()`** / **`coord_trans()`**：变换后的笛卡尔坐标系

## 笛卡尔坐标系

笛卡尔坐标系是最常见的坐标系类型。对坐标系设置边界限制相当于对图形进行缩放（就像你拿着放大镜观察它一样），这不会改变底层数据；而在坐标轴（scale）上设置边界限制则会改变底层数据。

```R
coord_cartesian(
  xlim = NULL,
  ylim = NULL,
  expand = TRUE,
  default = FALSE,
  clip = "on",
  reverse = "none",
  ratio = NULL
)
```



## 参考

- https://ggplot2.tidyverse.org/reference/
- https://ggplot2.tidyverse.org/reference/coord_cartesian.html