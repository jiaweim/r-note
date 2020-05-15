# Factor

- [Factor](#factor)
  - [简介](#%e7%ae%80%e4%bb%8b)
  - [函数](#%e5%87%bd%e6%95%b0)
    - [tapply](#tapply)

2020-05-15, 21:05
***

## 简介

在 R 中，factor可以看作一个附加了额外信息的向量，指定向量元素的离散分类（分组）。

R 提供了有序和无序 factors。

例如：

```r
> x <- c(5, 12, 13, 12)
> xf <- factor(x)
> xf
[1] 5  12 13 12
Levels: 5 12 13
```

额外信息 level 可以表示等级，或者说类别。再看 `xf` 内部信息：

```r
> str(xf)
 Factor w/ 3 levels "5","12","13": 1 2 3 2
> unclass(xf)
[1] 1 2 3 2
attr(,"levels")
[1] "5"  "12" "13"
```

其中的 `1 2 3 2` 可以看作数据分类。

还可以在定义时指定 level:

```r
xff <- factor(x, levels = c(5, 12, 13, 88))
```

虽然 `xff` 不含有 88，但是额外的level是允许的。

## 函数

### tapply

`tapply(x, f, g)`

- x 对应向量
- f 对应因子
- g 对应函数

假设 x 表示选民年龄，因子 f 为选民党派（民主党、共和党、无党派），现在希望得到每个党派选民的平均年龄。

`tapply()` 将 x 根据因子分组，得到 x 的子向量，然后对这些字向量应用函数。例如：

```r
> ages <- c(25, 26, 55, 37, 21, 42)
> affils <- c("R", "D", "D", "R", "U", "D")
> tapply(ages, affils, mean)
 D  R  U
41 31 21
```


