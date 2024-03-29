# 概率分布

- [概率分布](#概率分布)
  - [简介](#简介)
  - [应用](#应用)
  - [t 分布](#t-分布)
  - [正态分布](#正态分布)
    - [随机数](#随机数)

2020-08-12, 10:13
***

## 简介

R 中内置了许多生成随机数的函数。对应不同的分布。

R 中统计函数名称由前缀和后缀组成：

- 前缀
  - d 表示分布密度函数（PDF）或概率函数（PMF）
  - p 表示累计分布函数（CDF）$F(q)=P(x\le q)$
  - q 表示分位数
  - r 表示随机
- 后缀标识分布类型

| 分布 | 缩写 | 参数 | 函数 |
|--|--|--|--|
| 正态分布 | norm | mean, sd | dnorm, pnorm, qnorm, rnorm |
| 二项分布 | binom | size, prob | dbinom, pbinom, qbinom, rbinom |
| 泊松分布 | pois | lambda | dpois, ppois, qpois, rpois |
| 超几何分布 | hyper | m, n, k | dhyper, phyper, qhyper, rhyper |
| 卡方分布 | chisq | df, ncp | dchisq, pchisq, qchisq, rchisq |
| t 分布 | r | df,ncp | dt, pt, qt, rt |
| F 分布 | f | df1, ncp | df, pf, qf, rf |
| 负二项分布 | nbinom | size, prob | dnbinom, pnbinom, qnbinom, rnbinom |
| 指数分布 | exp | rate | dexp, pexp, qexp, rexp |

dxxx(x) 函数加选项 `log=TRUE`，用来计算 $log p(x)$，比使用 `log(dxxx(x))` 更精确。

pxxx(q) 加选项 `lower.tail=FALSE`，计算 $P(X > q)=1-F(q)$。

qxxx(p) 加选项 `lower.tail=TRUE`，表示计算 $P(X > x)=p$ 的解x；加选项 `log.p=TRUE`，表示输入的 p 实际是 $lnp$。

这些函数都可以带有自己的分布参数，有些分布参数有缺省值，比如正态分布的缺省参数值均值为0，标准差为1.

常见的分布密度函数有：

- 离散分布
  - 二项分布，dbinom
  - 泊松分布，dpois
  - 几何分布，dgeom
  - 负二项分布，dnbinom
  - 多项分布，dmultinom
  - 超几何分布，dhyper
- 连续分布
  - 均匀分布，dunif
  - 正态分布，dnorm
  - 卡方分布，dchisq
  - t 分布，dt
  - F 分布，df
  - 指数分布，dexp
  - 威布尔分布，dweibull
  - 伽马分布，dgamma
  - 贝塔分布，dbeta
  - 对数正态分布，dlnorm
  - 柯西分布，dcauchy
  - 逻辑斯谛分布，dlogis

更多分布可以参考 R 网站 [https://cran.r-project.org/web/views/Distributions.html](https://cran.r-project.org/web/views/Distributions.html)。

## 应用

生活中许多连续型随机变量服从正态分布，如人体身高、作物产量等。

离散型随机变量满足二项分布、泊松分布等，如基于 RNA-seq 得到的基因表达丰富计数值就可用泊松分布来近似，而在做基因表达差异分析时，多采用负二项分布模型进行分析。

## t 分布



## 正态分布

### 随机数

```r
rnorm(n, mean = 0, sd = 1)
```

默认使用均值为 0 标准差为 1的标准分布。

如果想生成固定的随机数，可以使用 `set.seed()` 函数设置 seed。

```r
> set.seed(1303)
> rnorm(50)
 [1] -1.1439763145  1.3421293656  2.1853904757  0.5363925179
 [5]  0.0631929665  0.5022344825 -0.0004167247  0.5658198405
 [9] -0.5725226890 -1.1102250073 -0.0486871234 -0.6956562176
[13]  0.8289174803  0.2066528551 -0.2356745091 -0.5563104914
[17] -0.3647543571  0.8623550343 -0.6307715354  0.3136021252
[21] -0.9314953177  0.8238676185  0.5233707021  0.7069214120
[25]  0.4202043256 -0.2690521547 -1.5103172999 -0.6902124766
[29] -0.1434719524 -1.0135274099  1.5732737361  0.0127465055
[33]  0.8726470499  0.4220661905 -0.0188157917  2.6157489689
[37] -0.6931401748 -0.2663217810 -0.7206364412  1.3677342065
[41]  0.2640073322  0.6321868074 -1.3306509858  0.0268888182
[45]  1.0406363208  1.3120237985 -0.0300020767 -0.2500257125
[49]  0.0234144857  1.6598706557
```
