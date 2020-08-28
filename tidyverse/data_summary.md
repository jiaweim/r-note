# 数据汇总

- [数据汇总](#数据汇总)
  - [数据统计-summarise](#数据统计-summarise)
    - [summarise API](#summarise-api)
    - [summarise 实例](#summarise-实例)
  - [多个变量的汇总](#多个变量的汇总)
  - [数据分组](#数据分组)
    - [分组筛选](#分组筛选)
  - [交叉分类](#交叉分类)

2020-08-26, 17:41
@Jiawei Mao
***

## 数据统计-summarise

### summarise API

dplyr 包的 `summarise()` 函数可以对数据框计算统计量。

`summarise()` 根据数据创建一个新的数据框。每个分组变量组合对应一行；如果没有分组变量，则只输出一行，汇总输入中的所有值。

`summarise()` 和 `summarize()` 等同。

语法：

```r
summarise(.data, ..., .groups = NULL)

summarize(.data, ..., .groups = NULL)
```

参数说明：

- `.data` 为数据框
- `...`，summary 函数。以name-value 的形式指定，name 为输出结果中对应变量名称。value 有：
  - 长度为 1 的向量，如 `min(x)`, `n()`, `sum(is.na(y))`
  - 长度为 n 的向量，如 `quantile()`
  - 数据框，对单个表达式生成多列
- `groups`，结果分组
  - "drop_last"，删除分组的最后一层。版本 1.0.0 支持只支持该操作
  - "drop"，删除所有分组
  - "keep"，和 `.data` 相同的分组结果
  - "rowwise"，每一行对应一个分组

`summarise` 中常用的函数汇总：

- 集中趋势: `mean()`, `median()`
- 分散程度：`sd()`, `IQR()`, `mad()`
- 范围：`min()`, `max()`, `quantile()`
- 位置
  - `first(x)` 取出 `x[1]`
  - `last(x)` 取出 x 的最后一个元素
  - `nth(x, 2)` 取出 `x[2]`
- 计数
  - `n()` 给出元素个数
  - `sum(!is.na(x))` 统计 x 的非缺失值个数
  - `n_distinct(x)` 统计 x 的不同值个数
  - `count(x)` 给出 x 的每个不同值的个数
- 逻辑：`any()`, `all()`

### summarise 实例

以肺癌病人的数据 `cancer.csv` 为例，有34个肺癌病人的数据：

```r
> d.cancer <- read_csv("src/data/cancer.csv",
+   locale = locale(encoding = "GBK")
+ )
Parsed with column specification:
cols(
  id = col_double(),
  age = col_double(),
  sex = col_character(),
  type = col_character(),
  v0 = col_double(),
  v1 = col_double()
)
>
> knitr::kable(d.cancer)

| id| age|sex |type |     v0|     v1|
|--:|---:|:---|:----|------:|------:|
|  1|  70|F   |腺癌 |  26.51|   2.91|
|  2|  70|F   |腺癌 | 135.48|  35.08|
|  3|  69|F   |腺癌 | 209.74|  74.44|
|  4|  68|M   |腺癌 |  61.00|  34.97|
|  5|  67|M   |鳞癌 | 237.75| 128.34|
|  6|  75|F   |腺癌 | 330.24| 112.34|
|  7|  52|M   |鳞癌 | 104.90|  32.10|
|  8|  71|M   |鳞癌 |  85.15|  29.15|
|  9|  68|M   |鳞癌 | 101.65|  22.15|
| 10|  79|M   |鳞癌 |  65.54|  21.94|
| 11|  55|M   |腺癌 | 125.31|  12.33|
| 12|  54|M   |鳞癌 | 224.36|  99.44|
| 13|  55|F   |腺癌 |  12.93|   2.30|
| 14|  75|M   |腺癌 |  40.21|  23.96|
| 15|  61|F   |腺癌 |  12.58|   7.39|
| 16|  76|M   |鳞癌 | 231.04| 112.58|
| 17|  65|M   |鳞癌 | 172.13|  91.62|
| 18|  66|M   |鳞癌 |  39.26|  13.95|
| 19|  NA|F   |腺癌 |  32.91|   9.45|
| 20|  63|F   |腺癌 | 161.00| 122.45|
| 21|  67|M   |鳞癌 | 105.26|  68.35|
| 22|  51|M   |鳞癌 |  13.25|   5.25|
| 23|  49|M   |鳞癌 |  18.70|   3.34|
| 24|  49|M   |鳞癌 |  60.23|  50.36|
| 25|  NA|F   |鳞癌 | 223.00|  25.59|
| 26|  NA|M   |鳞癌 | 145.70|  35.36|
| 27|  NA|M   |鳞癌 | 138.44|  11.30|
| 28|  NA|M   |鳞癌 |  83.71|  76.45|
| 29|  NA|M   |鳞癌 |  74.48|  23.66|
| 30|  NA|F   |腺癌 |  42.70|   5.97|
| 31|  NA|M   |鳞癌 | 142.48|  68.46|
| 32|  NA|F   |鳞癌 |  46.97|  27.32|
| 33|  NA|F   |鳞癌 | 170.63|  74.76|
| 34|  NA|F   |鳞癌 |  67.37|  54.52|
```

下面，求年龄的个数，非缺失值个数，平均值以及标准差：

```r
> d.cancer %>%
+   summarise(
+     nobs = n(),
+     n = sum(!is.na(age)),
+     mean.age = mean(age, na.rm = TRUE),
+     sd.age = sd(age, na.rm = TRUE)
+   ) %>%
+   knitr::kable()


| nobs|  n| mean.age|   sd.age|
|----:|--:|--------:|--------:|
|   34| 23| 64.13043| 9.161701|
```

说明：

- `n()` 计算观测数（行数）
- `sum(!is.na(x))` 计算非缺失值个数

## 多个变量的汇总

在需要对多个变量进行汇总时，`summarise` 的格式就会比较啰嗦。比如，需要对 `cancer` 数据集中 `v0` 和 `v1` 两个变量同时计算平均值和标准差：

```r
> d.cancer %>%
+   summarise(
+     mean.v0 = mean(v0, na.rm = TRUE),
+     sd.v0 = sd(v0, na.rm = TRUE),
+     mean.v1 = mean(v1, na.rm = TRUE),
+     sd.v1 = sd(v1, na.rm = TRUE),
+   ) %>%
+   knitr::kable()


|  mean.v0|    sd.v0|  mean.v1|    sd.v1|
|--------:|--------:|--------:|--------:|
| 110.0768| 79.52338| 44.69353| 38.44172|
```

如果有许多变量要计算，人为为每个变量命名就很烦。`summarse_at()` 函数可以指定一批变量名与一批统计函数，自动命名结果变量，例如：

```r
> d.cancer <- read_csv("src/data/cancer.csv")
> d.cancer %>%
+   summarise_at(
+     c("v0", "v1"),
+     list(avg = ~ mean(.), std = ~ sd(.)),
+     na.rm = TRUE
+   ) %>%
+   knitr::kable()

|   v0_avg|   v1_avg|   v0_std|   v1_std|
|--------:|--------:|--------:|--------:|
| 110.0768| 44.69353| 79.52338| 38.44172|
```

其中 `na.rm` 选项作为 `...` 格式的参数传递给统计函数 `mean` 和 `sd`。`summarise_at` 的第三个变量可以取：

- 一个函数，如 `mean`；
- 一个如 `~ f(.)` 这样的自定义无名函数，其中 `.` 表示自变量；
- 函数或者自定义无名函数的列表

结果统计量自动命名为“变量名_统计量名”的格式。

其中的变量子集也可以用序号范围表示，或者用 `vars()` 函数写成不加撇好的格式。例如：

```r
> d.cancer %>%
+   summarise_at(
+     5:6,
+     list(avg = ~ mean(.), std = ~ sd(.)),
+     na.rm=TRUE
+   ) %>%
+   knitr::kable()


|   v0_avg|   v1_avg|   v0_std|   v1_std|
|--------:|--------:|--------:|--------:|
| 110.0768| 44.69353| 79.52338| 38.44172|
```

或者：

```r
> d.cancer %>%
+   summarise_at(
+     vars(v0, v1),
+     list(avg = ~ mean(.), std = ~ sd(.)),
+     na.rm=TRUE
+   ) %>%
+   knitr::kable()

|   v0_avg|   v1_avg|   v0_std|   v1_std|
|--------:|--------:|--------:|--------:|
| 110.0768| 44.69353| 79.52338| 38.44172|
```

## 数据分组

dplyr 的 `group_by()` 函数对数据框或 tibble 分组，随后 `summarise()` 将按照分组汇总。

比如，按不同性别分组计算人数与年龄平均值：

```r
> library(tidyverse)
>
> d.cancer <- read_csv("src/data/cancer.csv")
Parsed with column specification:
cols(
  id = col_double(),
  age = col_double(),
  sex = col_character(),
  type = col_character(),
  v0 = col_double(),
  v1 = col_double()
)
> d.cancer %>%
+   group_by(sex) %>%
+   summarise(
+     count = n(),
+     mean.age = mean(age, na.rm = TRUE)
+   ) %>%
+   knitr::kable()
`summarise()` ungrouping output (override with `.groups` argument)


|sex | count| mean.age|
|:---|-----:|--------:|
|F   |    13| 66.14286|
|M   |    21| 63.25000|
```

按不同性别分组计算 v0 和 v1 的人数、平均值、标准差：

```r
> d.cancer %>%
+   group_by(sex) %>%
+   summarise_at(
+     c("v0", "v1"),
+     list(count = ~ n(), avg = ~ mean(.), std = ~ sd(.)),
+     na.rm = TRUE
+   ) %>%
+   knitr::kable()


|sex | v0_count| v1_count|   v0_avg|   v1_avg|    v0_std|   v1_std|
|:---|--------:|--------:|--------:|--------:|---------:|--------:|
|F   |       13|       13| 113.2354| 42.65538| 100.06621| 41.72226|
|M   |       21|       21| 108.1214| 45.95524|  66.45374| 37.27592|
```

上面的 count 应该合并，但是 `summarise_at` 在有多个变量和多个统计量时总会将变量两两搭配，输出结果就会变得繁琐。

```r
> bind_cols(
+   d.cancer %>%
+     group_by(sex) %>%
+     summarise(count = n()),
+   d.cancer %>%
+     group_by(sex) %>%
+     summarise_at(
+       c("v0", "v1"),
+       list(avg = ~ mean(.), std = ~ sd(.)),
+       na.rm = TRUE
+     ) %>%
+     select(-sex)
+ )
`summarise()` ungrouping output (override with `.groups` argument)
# A tibble: 2 x 6
  sex   count v0_avg v1_avg v0_std v1_std
  <chr> <int>  <dbl>  <dbl>  <dbl>  <dbl>
1 F        13   113.   42.7  100.    41.7
2 M        21   108.   46.0   66.5   37.3
```

为了查询数值型变量取值满足某种条件的个数和比例，可以将该条件用 `sum()` 和 `mean()` 函数统计，比如，对男女两组分别计算年龄在 60 岁以上的人数和比例：

```r
> d.cancer %>%
+   group_by(sex) %>%
+   summarise(
+     nold = sum(age >= 60, na.rm = TRUE),
+     pold = nold / n()
+   ) %>%
+   knitr::kable()
`summarise()` ungrouping output (override with `.groups` argument)


|sex | nold|      pold|
|:---|----:|---------:|
|F   |    6| 0.4615385|
|M   |   10| 0.4761905|
```

### 分组筛选

用 `group_by` 分组后可以对各个分组进行筛选。下面找出治疗前体积（v0）排名前两名的：

```r
> d.cancer %>%
+   group_by(sex) %>%
+   filter(rank(desc(v0)) <= 2) %>%
+   arrange(sex, desc(v0)) %>%
+   knitr::kable()


| id| age|sex |type |     v0|     v1|
|--:|---:|:---|:----|------:|------:|
|  6|  75|F   |腺癌 | 330.24| 112.34|
| 25|  NA|F   |鳞癌 | 223.00|  25.59|
|  5|  67|M   |鳞癌 | 237.75| 128.34|
| 16|  76|M   |鳞癌 | 231.04| 112.58|
```

## 交叉分类

下面对 d.cancer 数据框分性别与病理类别分别统计人数：

```r
> d.cancer %>%
+   group_by(sex, type) %>%
+   summarise(freq = n()) %>%
+   knitr::kable()
`summarise()` regrouping output by 'sex' (override with `.groups` argument)


|sex |type | freq|
|:---|:----|----:|
|F   |腺癌 |    9|
|F   |鳞癌 |    4|
|M   |腺癌 |    3|
|M   |鳞癌 |   18|
```

如果只需要计算交叉分类频数，不需要用 `group_by()`，可以用 `count()` 函数。例如：

```r
> d.cancer %>%
+   count(sex, type) %>%
+   knitr::kable()


|sex |type |  n|
|:---|:----|--:|
|F   |腺癌 |  9|
|F   |鳞癌 |  4|
|M   |腺癌 |  3|
|M   |鳞癌 | 18|
```

下面统计 NHANES 数据框中 ID与 SurveyYr 每一对组合的出现次数，筛选出不少于2次的组合，并降序排列，仅显示前10行结果：

```r
> library(tidyverse)
> library(NHANES)
>
> NHANES %>%
+   count(ID, SurveyYr) %>%
+   filter(n >= 2) %>%
+   arrange(desc(n)) %>%
+   head(10) %>%
+   knitr::kable()


|    ID|SurveyYr |  n|
|-----:|:--------|--:|
| 70324|2011_12  |  8|
| 62927|2011_12  |  7|
| 63297|2011_12  |  7|
| 69626|2011_12  |  7|
| 60566|2009_10  |  6|
| 61442|2009_10  |  6|
| 63163|2011_12  |  6|
| 63330|2011_12  |  6|
| 63390|2011_12  |  6|
| 63744|2011_12  |  6|
```

用 `group_by()` 交叉分组汇总后的结果不是普通的 tibble，而是带有外层分组信息，最内层的分组信息失效。