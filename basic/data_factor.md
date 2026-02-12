# 因子类型

2020-06-10, 10:33
***

## 简介

factor 用于存储分类信息，比如性别、种族、省份、职业等。

R 提供有序和无序 factor，有序因子代表有序量，如打分、疾病严重程度等。

## 创建 factor

使用 `factor()` 函数创建因子。R 会：

- 记录数据，将其转换为整数，并存储为整数向量
- 添加 `levels` 属性，为每个 factor 值添加一个标签
- 添加 `class` 属性，为 `factor`

```r
factor(x = character(), levels, labels = levels,
       exclude = NA, ordered = is.ordered(x), nmax = NA)
ordered(x, …)

is.factor(x)
is.ordered(x)

as.factor(x)
as.ordered(x)

addNA(x, ifany = FALSE)
```

**参数：**

- `x`，输入的数据向量；
- `levels`，指定各 level 值，默认按字母顺序；
- `labels`，各个 level 的标签；
- `exclude`，从 x 中剔除的水平值；
- `ordered`，因子水平是否有序；
- `nmax`，水平个数限制。

例如：

```R
> gender <- factor(c("male", "female", "female", "male"))
> typeof(gender)
[1] "integer"
> attributes(gender)
$levels
[1] "female" "male"  

$class
[1] "factor"
```

使用 `unclass()` 属性可以查看 R 是如何存储 factor 的：

```R
> unclass(gender)
[1] 2 1 1 2
attr(,"levels")
[1] "female" "male"
```

在显式 factor 时，R 用 `levels` 属性值。对每个 1，显示为 "female"，每个 2 显示为 "male"。

```R
> gender
[1] male   female female male  
Levels: female male
```

factor 使得将分类变量放入统计模型变得容易，因为这些变量已经被编码为数字。不过，因子让人困惑的地方在于，它看起来是字符串，但行为像整数。

在加载和创建数据时，R 通常会尝试将字符串转换为因子。一般来说，禁止 R 自动转换为因子性能更好。



可以看到

- `levels` 属性对应可选值，可以通过 `levels()` 函数访问。

### 类型转换

`read.csv()` 函数默认会把输入文件的字符型列自动转换成因子，这对于性别、职业、地名类型的类很合适，不过对姓名、日期、详细地址这样的列就不合适了。所以在使用 `read.csv()` 时经常会加选项 `stringsAsFactors=FALSE` 禁止这样的自动转换，也可以用 `colClasses` 选项逐个指定每个列的类型。

用 `as.numeric()` 可以把因子转换为整数。如：

```r
> as.numeric(sex)
[1] 2 1 2 2 1
```

因为因子实际保存为整数值，所以对因子进行字符型操作会导致错误。用 `as.character()` 可以把因子转换为字符类型，如：

```r
> as.character(sex)
[1] "Male"   "Female" "Male"   "Male"   "Female"
```

### levels

`factor` 的 `levels` 可以看作映射，把整数值 1, 2, ... 映射到 level 值。这样可以节省内存。`factor()` 函数签名：

```r
factor(x, levels = sort(unique(x), na.last = TRUE),
       labels, exclude = NA, ordered = FALSE)
```

`levels` 指定各等级的标签，默认使用各等级对应字符串。因为向量可能没有包含所有的水平，所有有时候有必要使用 `levels` 指定所有的水平值。

如果指定了 `levels`，则当自变量 `x` 的某个元素等于第 `j` 个等级值时，其因子对应整数 `j`，如果该元素值没有在 `levels` 中出现，其因子为 NA。

`exclude` 指定转换为缺失值（NA）的元素值集合。

`ordered` 去 TRUE 时表示因为等级有次序。

在使用 `factor()` 函数定义因子时，如果知道自变量元素的所有可能取值，则应该用 `levels=` 指定这些值。

因为 `levels` 值的唯一性，在合并两个因子时有些问题。例如：

```r
> li1 <- factor(c("Male", "Female"))
> li2 <- factor(c("Male", "Male"))
> c(li1, li2)
[1] 2 1 1 1
```

结果不是因子类型。正确的做法是：

```r
> factor(c(as.character(li1), as.character(li2)))
[1] Male   Female Male   Male  
Levels: Female Male
```

即恢复成字符串后再合并，然后再转换成因子。当然，如果在定义 `li1` 和 `li2` 时都指定了 `levels` 选项，也能给出正确结果。

## factor 实例

对正数，如：

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

## table 函数

`table()` 函数统计因子各水平出现的次数。也可以对一般的向量统计。例如：

```r
> sex
[1] Male   Female Male   Male   Female
Levels: Female Male
> table(sex)
sex
Female   Male
     2      3
```

## tapply

假设我们有另一个向量，该向量包含所有会计的收入：

```r
> incomes <- c(60, 49, 40, 61, 64, 60, 59, 54, 62, 69, 70, 42, 56,
+              61, 61, 61, 58, 51, 48, 65, 49, 49, 41, 48, 52, 46,
+              59, 46, 58, 43)
```

要计算每个地区的平均收入，此时可以使用 `tapply()` 函数：

```r
> incmeans <- tapply(incomes, statef, mean)
> incmeans
     act      nsw       nt      qld       sa      tas      vic       wa
44.50000 57.33333 55.50000 53.60000 55.00000 60.50000 56.00000 52.25000
```

`tapply()` 将指定函数（第三个参数，如 mean）应用到向量（第一个参数，如 incomes）的每个分组，分组由第二个参数（此处为 `statef`）确定。返回结果的长度和 factor 相同。

`tapply(x, f, g)`

- x 对应向量
- f 对应因子
- g 对应函数

假设我们还想计算收入的标准差。为此我们首先需要实现计算标准差的函数。已有内置函数 `var()` 计算样本方差，该函数是一个很简单呐的线性函数：

```r
> stdError <- function(x) sqrt(var(x)/length(x))
```

然后，我们就可以使用该函数计算不同地区收入的标准差：

```r
> incster <- tapply(incomes, statef, stdError)
> incster
     act      nsw       nt      qld       sa      tas      vic       wa
1.500000 4.310195 4.500000 4.106093 2.738613 0.500000 5.244044 2.657536
```

## Ordered factor

Factor 的 levels 按照字母顺序存储，或者根据指定的顺序存储。

而 levels 有时具有自然顺序，如数值类型。`Ordered()` 函数用于创建此类有序 factor，这类 factor 其它行为和常规 factor 一样。

大多时候，有序和无序 factor 的唯一差别是，输出的level具有顺序。

## forcats 包的因子函数

```r
library(forcats)
```

在分类变量种类较多时，往往需要对因子水平进行排序、合并等，`forcats` 包提供了一些针对因子的实用函数。

`forcats::fac_reorder()` 根据不同因子水平分成的组中另一数值型变量的统计量值排序。 如：

```r
> library(forcats)
> set.seed(1)
> fac <- sample(c("red", "green", "blue"), 30, replace = TRUE)
> x <- round(100*(10+rt(30, 2)))
> res1 <- tapply(x, fac, sd)
> res1
     blue     green       red
1129.2587  138.3185  370.9222
```

## gl

```r
gl(n, k, length = n*k, labels = seq_len(n), ordered = FALSE)
```

生成因子水平。

**参数：**

- `n`，level 个数；
- `k`，每个 level 重复的次数；
- `length`，设置的长度；
- `labels`，各个 level 的值；
- `ordered`，确定 level 是否有序。

```r
> v <- gl(3, 4, labels = c('Google', 'Taobao', 'Runoob'))
> print(v)
 [1] Google Google Google Google Taobao Taobao Taobao Taobao Runoob Runoob Runoob
[12] Runoob
Levels: Google Taobao Runoob
```

## 参考

- https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/factor
- https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/gl
