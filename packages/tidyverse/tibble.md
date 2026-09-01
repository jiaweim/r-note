# Tibble

2026-09-01
@author Jiawei Mao

***

## 简介

`tibble` 是增强的 `data.frame`，选取 `tibble` 的行或列，即使遇到当行或单列，数据也不会降维，总是返回 `tibble`。

- tibble 数据库的打印格式更紧凑
- 不自动将字符串转换为因子（新版 R 也不会）
- 不自动降维，例如，对应 `mtcars[, "mpg"]` 对 `data.frame` 提取子集，将返回一个向量，而不是单列的数据库。而 `mtcars[, "mpg"]` 对 `tibble` 数据框会返回单列 tibble 数据库，不会降维
- 定义时不需要 column 名称合法，不过在引用变量名是需要用反撇号 `` 包起来。
- tibble 不支持行名，将数据框用 `as_tibble()` 转换为 tibble 时，可以用 `rownames="变量名"` 选项将行转换为 tibble 的一列，其中 "变量名" 对应该列名。
- tibble 允许列为列表类型。

> [!NOTE]
>
> - R 中的句点 `.` 没有特殊意义，但美元符号 `$` 用于指定数据框或列表中的成分
> - R 不提供多行注释，多行注释只能每一行以 `#` 开头

## 创建 tibble

### tibble

`tibble()` 根据输入的向量创建 `tibble`，而且在其中可以引用刚创建的变量，例如：

```r
> tibble(
+   x = 1:5,
+   y = 1,
+   z = x^2 + y
+ )
# A tibble: 5 x 3
      x     y     z
  <int> <dbl> <dbl>
1     1     1     2
2     2     1     5
3     3     1    10
4     4     1    17
5     5     1    26
```

### 使用不规范名称

在 tibble 中可以使用不规范的列名称，不过在引用时，需要用反引号 ` 将名称括起来：

```r
> tb <- tibble(
+   `:)` = 'smile',
+   ` ` = "space",
+   `2000` = "number"
+ )
> tb
# A tibble: 1 x 3
  `:)`  ` `   `2000`
  <chr> <chr> <chr> 
1 smile space number
```

在 ggplot2, dplyr, tidyr 等包中，对不规范名称的引用，都需要添加反引号。

### tribble

`tribble()` 是 transposed tibble 缩写，即转置的 tibble。方便在代码中定义小的数据集：列标题以 `~` 开头定义，每一列以逗号分隔，方便阅读，例如：

```r
> tribble(
+   ~x, ~y, ~z,
+   "a", 2, 3.6,
+   "b", 1, 8.5
+ )
# A tibble: 2 x 3
  x         y     z
  <chr> <dbl> <dbl>
1 a         2   3.6
2 b         1   8.5
```

### data.frame 转 tibble

`as_tibble()` 将 `data.frame` 转换为 tibble：

```r
> library(tibble)
> mtcars <- as_tibble(mtcars)
> mtcars
# A tibble: 32 × 11
     mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
 1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
 2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
 3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
 4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
 5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
 6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
 7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
 8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
 9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
# ℹ 22 more rows
# ℹ Use `print(n = ...)` to see more rows
```

## Tibble vs. data.frame

tibble 和 `data.frame` 的使用主要有两个差异：print 和 subset.

### print

Tibble 的打印方法进行了修改，只显示前 10 行，并尽可能多的显示列。这样对大规模数据比较友好。除了标题，还输出每一列的类型：

```r
tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)
#> # A tibble: 1,000 x 5
#>   a                   b              c     d e    
#>   <dttm>              <date>     <int> <dbl> <chr>
#> 1 2020-05-08 23:14:55 2020-05-15     1 0.368 n    
#> 2 2020-05-09 17:20:05 2020-05-20     2 0.612 l    
#> 3 2020-05-09 11:43:44 2020-05-30     3 0.415 p    
#> 4 2020-05-09 01:05:01 2020-05-29     4 0.212 m    
#> 5 2020-05-08 21:29:18 2020-05-26     5 0.733 i    
#> 6 2020-05-09 08:30:15 2020-05-22     6 0.460 n    
#> # … with 994 more rows
```

如果想输出更多内容到控制台，有如下实现方式。

- 直接设置输出的行数 `n` 和宽度 `width`

宽度设置为 `width = Inf` 表示显示所有列：

```r
nycflights13::flights %>% 
  print(n = 10, width = Inf)
```

