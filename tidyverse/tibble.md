# Tibble

- [Tibble](#tibble)
  - [简介](#简介)
  - [创建 tibble](#创建-tibble)
    - [tibble](#tibble-1)
    - [使用不规范名称](#使用不规范名称)
    - [tribble](#tribble)
    - [data.frame 转 tibble](#dataframe-转-tibble)
  - [Tibble vs. data.frame](#tibble-vs-dataframe)
    - [print](#print)

2020-09-08, 13:58
@jiawei
***

## 简介

`tibble` 是增强的 `data.frame`，选取 `tibble` 的行或列，即使遇到当行或单列，数据也不会降维，总是返回 `tibble`。

- 不自动将字符串转换为因子。
- 不自动降维
- 定义时不需要列名称合法，不过在引用变量名是需要用反撇号 `` 包起来。
- tibble 不支持行名，将数据框用 `as_tibble()` 转换为 tibble 时，可以用 `rownames="变量名"` 选项将行转换为 tibble 的一列，其中 "变量名" 对应该列名。
- tibble 允许列为列表类型。

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

`as_tibble()` 将 `data.frame` 转换为 tibble:

```r
> as_tibble(iris)
# A tibble: 150 x 5
   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
          <dbl>       <dbl>        <dbl>       <dbl> <fct>  
 1          5.1         3.5          1.4         0.2 setosa 
 2          4.9         3            1.4         0.2 setosa 
 3          4.7         3.2          1.3         0.2 setosa 
 4          4.6         3.1          1.5         0.2 setosa 
 5          5           3.6          1.4         0.2 setosa 
 6          5.4         3.9          1.7         0.4 setosa 
 7          4.6         3.4          1.4         0.3 setosa 
 8          5           3.4          1.5         0.2 setosa 
 9          4.4         2.9          1.4         0.2 setosa 
10          4.9         3.1          1.5         0.1 setosa 
# ... with 140 more rows
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

