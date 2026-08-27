# Data Distribution

## Basic Histogram

使用 `geom_histogram()` 映射到连续变量 `x`:

```r
p <- ggplot(faithful, aes(x = faithful$waiting)) +
  geom_histogram()
print(p)
```

`geom_histogram()` 需要一列数据，

![histogram](images/2020-06-18-15-13-32.png)

