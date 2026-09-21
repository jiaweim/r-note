# ggrepel



## 概览

`ggrepel` 为 `ggplot2` 提供专门的几何图层，用来解决文本标签重叠的问题，主要包括：

- `geom_text_repel()`
- `geom_label_repel()`

使用了这些函数后，文本标签就会像带有磁性一样“互相排斥”：它们不仅会避开彼此、避开数据点，还会自动躲开绘图区域的边缘，让图表看起来清爽很多。

```R
library(ggrepel)
ggplot(mtcars, aes(wt, mpg, label = rownames(mtcars))) +
  geom_text_repel() +
  geom_point(color = 'red') +
  theme_classic(base_size = 16)
```

## 安装

```R
# 从 CRAN 安装
install.packages("ggrepel")

# 从 GitHub 安装最新开发版
# install.packages("devtools")
devtools::install_github("slowkow/ggrepel")
```

## 参考

- https://ggrepel.slowkow.com/