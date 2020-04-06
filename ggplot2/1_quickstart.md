# Quickstart

graphing template

```r
ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = axes(<MAPPINGS>))
```

例1：

```r
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
```

绘制散点图。

例2：

```r
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
```

数据点的颜色和 `class` 属性关联。

例3：创建子图
```r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
```

ggplot()	creates a coordinate system that you can add layers to
geom_point()	

# shape
ggplot2 最多使用6种形状，不绘制额外的分组数据。

ggplot2 内置的形状：
