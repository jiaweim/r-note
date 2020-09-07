# slice

- [slice](#slice)
  - [简介](#简介)
  - [方法签名](#方法签名)
  - [实例](#实例)
    - [选择开头 5 行](#选择开头-5-行)
    - [选择最后 5 行](#选择最后-5-行)
    - [选择值最小的 5 行](#选择值最小的-5-行)
    - [选择值最大的 5 行](#选择值最大的-5-行)
  - [参考](#参考)

2020-09-07, 18:55
@jiawei
***

## 简介

`slice()` 根据位置选择 rows，可对 rows 进行选择、移除以及去重操作。还包含一些辅助函数：

- `slice_head()` 和 `slice_tail()` 选择首行和末行。
- `slice_sample()` 随机选择行。
- `slice_min()` 和 `slice_max()` 根据指定变量选择最大或最小行。

如果 `.data` 是 `grouped_df` 类型，则上面的操作对每个分组分别进行，因此 `slice_head(df, n=5)` 对分隔分组各取前 5 行。

## 方法签名

```r
slice(.data, ..., .preserve = FALSE)

slice_head(.data, ..., n, prop)

slice_tail(.data, ..., n, prop)

slice_min(.data, order_by, ..., n, prop, with_ties = TRUE)

slice_max(.data, order_by, ..., n, prop, with_ties = TRUE)

slice_sample(.data, ..., n, prop, weight_by = NULL, replace = FALSE)
```

返回：和 `.data` 相同类型的数据框。

1. `.data`

数据框。

2. `...`

待选择的行。

## 实例

- 选择第一行

```r
> mtcars %>% slice(1L)
          mpg cyl disp  hp drat   wt  qsec vs am gear carb
Mazda RX4  21   6  160 110  3.9 2.62 16.46  0  1    4    4
```

- 选择最后一行

```r
> mtcars %>% slice(n())
            mpg cyl disp  hp drat   wt qsec vs am gear carb
Volvo 142E 21.4   4  121 109 4.11 2.78 18.6  1  1    4    2
```

- 选择第5行到末尾

```r
> mtcars %>% slice(5:n())
                     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

- 移除1到4行

使用减号可以指定移除哪些行，所以下面结果和上面相同。

```r
slice(mtcars, -(1:4))
```

### 选择开头 5 行

根据当前顺序进行选择。

```r
> mtcars %>% slice_head(n = 5)
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
```

### 选择最后 5 行

```r
> mtcars %>% slice_tail(n = 5)
                mpg cyl  disp  hp drat    wt qsec vs am gear carb
Lotus Europa   30.4   4  95.1 113 3.77 1.513 16.9  1  1    5    2
Ford Pantera L 15.8   8 351.0 264 4.22 3.170 14.5  0  1    5    4
Ferrari Dino   19.7   6 145.0 175 3.62 2.770 15.5  0  1    5    6
Maserati Bora  15.0   8 301.0 335 3.54 3.570 14.6  0  1    5    8
Volvo 142E     21.4   4 121.0 109 4.11 2.780 18.6  1  1    4    2
```

### 选择值最小的 5 行

下面选择 `mpg` 值最小的 5 行。

```r
> mtcars %>% slice_min(mpg, n = 5)
                     mpg cyl disp  hp drat    wt  qsec vs am gear carb
Cadillac Fleetwood  10.4   8  472 205 2.93 5.250 17.98  0  0    3    4
Lincoln Continental 10.4   8  460 215 3.00 5.424 17.82  0  0    3    4
Camaro Z28          13.3   8  350 245 3.73 3.840 15.41  0  0    3    4
Duster 360          14.3   8  360 245 3.21 3.570 15.84  0  0    3    4
Chrysler Imperial   14.7   8  440 230 3.23 5.345 17.42  0  0    3    4
```

### 选择值最大的 5 行

```r
> mtcars %>% slice_max(mpg, n = 5)
                mpg cyl disp  hp drat    wt  qsec vs am gear carb
Toyota Corolla 33.9   4 71.1  65 4.22 1.835 19.90  1  1    4    1
Fiat 128       32.4   4 78.7  66 4.08 2.200 19.47  1  1    4    1
Honda Civic    30.4   4 75.7  52 4.93 1.615 18.52  1  1    4    2
Lotus Europa   30.4   4 95.1 113 3.77 1.513 16.90  1  1    5    2
Fiat X1-9      27.3   4 79.0  66 4.08 1.935 18.90  1  1    4    1
```

## 参考

- [Subset rows using their positions](https://dplyr.tidyverse.org/reference/slice.html)
