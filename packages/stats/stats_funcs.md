# R Stats 函数

------

## 📊 描述统计

| 函数             | 说明                 |
| ---------------- | -------------------- |
| `mean`           | 算术平均值           |
| `median`         | 中位数               |
| `sd`             | 标准差               |
| `var`            | 方差                 |
| `cor`            | 相关系数             |
| `cov`            | 协方差               |
| `cov.wt`         | 加权协方差矩阵       |
| `cov2cor`        | 协方差矩阵转相关矩阵 |
| `IQR`            | 四分位距             |
| `quantile`       | 样本分位数           |
| `fivenum`        | Tukey 五数概括       |
| `mad`            | 中位数绝对偏差       |
| `weighted.mean`  | 加权算术平均         |
| `mahalanobis`    | 马氏距离             |
| `complete.cases` | 查找完整观测         |
| `ave`            | 按因子分组求均值     |

------

## 🧪 假设检验

| 函数              | 说明                         |
| ----------------- | ---------------------------- |
| `t.test`          | Student's t 检验             |
| `var.test`        | F 检验（比较两个方差）       |
| `chisq.test`      | Pearson 卡方检验             |
| `fisher.test`     | Fisher 精确检验              |
| `prop.test`       | 比例检验                     |
| `prop.trend.test` | 比例趋势检验                 |
| `binom.test`      | 精确二项检验                 |
| `poisson.test`    | 精确 Poisson 检验            |
| `ansari.test`     | Ansari-Bradley 检验          |
| `bartlett.test`   | Bartlett 方差齐性检验        |
| `fligner.test`    | Fligner-Killeen 方差齐性检验 |
| `mood.test`       | Mood 两样本尺度检验          |
| `wilcox.test`     | Wilcoxon 秩和/符号秩检验     |
| `kruskal.test`    | Kruskal-Wallis 秩和检验      |
| `friedman.test`   | Friedman 秩和检验            |
| `quade.test`      | Quade 检验                   |
| `ks.test`         | Kolmogorov-Smirnov 检验      |
| `shapiro.test`    | Shapiro-Wilk 正态性检验      |
| `oneway.test`     | 单因素均值相等检验           |
| `mcnemar.test`    | McNemar 卡方检验             |
| `mantelhaen.test` | Cochran-Mantel-Haenszel 检验 |
| `Box.test`        | Box-Pierce / Ljung-Box 检验  |
| `PP.test`         | Phillips-Perron 单位根检验   |
| `mauchly.test`    | Mauchly 球形检验             |

------

## 📐 回归与模型拟合

| 函数                                             | 说明                       |
| ------------------------------------------------ | -------------------------- |
| `lm`                                             | 线性模型拟合               |
| `lm.fit` / `lm.wfit`                             | 线性模型底层拟合函数       |
| `glm`                                            | 广义线性模型拟合           |
| `nls`                                            | 非线性最小二乘             |
| `loess`                                          | 局部多项式回归             |
| `lowess`                                         | 散点图平滑                 |
| `lsfit`                                          | 最小二乘拟合               |
| `ppr`                                            | 投影寻踪回归               |
| `aov`                                            | 方差分析模型拟合           |
| `manova`                                         | 多元方差分析               |
| `ar` / `ar.burg` / `ar.mle` / `ar.ols` / `ar.yw` | 自回归模型拟合             |
| `arima` / `arima0`                               | ARIMA 时间序列建模         |
| `HoltWinters`                                    | Holt-Winters 指数平滑      |
| `StructTS`                                       | 结构时间序列模型           |
| `stl`                                            | STL 时间序列分解           |
| `decompose`                                      | 经典季节分解               |
| `factanal`                                       | 因子分析                   |
| `prcomp` / `princomp`                            | 主成分分析                 |
| `kmeans`                                         | K-Means 聚类               |
| `hclust`                                         | 层次聚类                   |
| `isoreg`                                         | 保序/单调回归              |
| `line`                                           | 稳健直线拟合               |
| `medpolish`                                      | 中位数抛光（稳健双向分解） |
| `smooth.spline`                                  | 平滑样条拟合               |
| `ksmooth`                                        | 核回归平滑                 |
| `supsmu`                                         | Friedman 超平滑            |
| `loglin`                                         | 对数线性模型拟合           |
| `runmed`                                         | 运行中位数平滑             |

------

## 🔬 模型诊断与推断

| 函数                               | 说明                 |
| ---------------------------------- | -------------------- |
| `AIC` / `BIC`                      | 信息准则             |
| `anova`                            | 方差分析表           |
| `coef` / `coefficients`            | 提取模型系数         |
| `confint`                          | 模型参数置信区间     |
| `deviance`                         | 模型偏差             |
| `logLik`                           | 对数似然             |
| `predict`                          | 模型预测             |
| `residuals` / `resid`              | 提取残差             |
| `fitted.values`                    | 提取拟合值           |
| `vcov`                             | 方差-协方差矩阵      |
| `sigma`                            | 残差标准差           |
| `nobs`                             | 观测数               |
| `step`                             | 逐步回归（AIC 选择） |
| `add1` / `drop1`                   | 添加/删除单项        |
| `alias`                            | 查找模型别名         |
| `profile`                          | 模型剖面             |
| `influence` / `influence.measures` | 回归诊断             |
| `cooks.distance`                   | Cook's 距离          |
| `hatvalues`                        | 杠杆值               |
| `rstandard` / `rstudent`           | 标准化/学生化残差    |
| `covratio`                         | 协方差比             |
| `dfbeta` / `dfbetas`               | 删除诊断             |
| `simulate`                         | 模拟响应             |
| `update`                           | 更新模型             |
| `getCall`                          | 获取模型调用         |

------

## 📈 概率分布（d / p / q / r）

| 分布              | 函数                                                         |
| ----------------- | ------------------------------------------------------------ |
| Beta              | `dbeta`, `pbeta`, `qbeta`, `rbeta`                           |
| Binomial          | `dbinom`, `pbinom`, `qbinom`, `rbinom`                       |
| Cauchy            | `dcauchy`, `pcauchy`, `qcauchy`, `rcauchy`                   |
| Chi-squared       | `dchisq`, `pchisq`, `qchisq`, `rchisq`                       |
| Exponential       | `dexp`, `pexp`, `qexp`, `rexp`                               |
| F                 | `df`, `pf`, `qf`, `rf`                                       |
| Gamma             | `dgamma`, `pgamma`, `qgamma`, `rgamma`                       |
| Geometric         | `dgeom`, `pgeom`, `qgeom`, `rgeom`                           |
| Hypergeometric    | `dhyper`, `phyper`, `qhyper`, `rhyper`                       |
| Log-Normal        | `dlnorm`, `plnorm`, `qlnorm`, `rlnorm`                       |
| Logistic          | `dlogis`, `plogis`, `qlogis`, `rlogis`                       |
| Multinomial       | `dmultinom`, `rmultinom`                                     |
| Negative Binomial | `dnbinom`, `pnbinom`, `qnbinom`, `rnbinom`                   |
| Normal            | `dnorm`, `pnorm`, `qnorm`, `rnorm`                           |
| Poisson           | `dpois`, `ppois`, `qpois`, `rpois`                           |
| Student t         | `dt`, `pt`, `qt`, `rt`                                       |
| Uniform           | `dunif`, `punif`, `qunif`, `runif`                           |
| Weibull           | `dweibull`, `pweibull`, `qweibull`, `rweibull`               |
| Wilcoxon          | `dsignrank`/`psignrank`/`qsignrank`/`rsignrank`, `dwilcox`/`pwilcox`/`qwilcox`/`rwilcox` |
| Tukey             | `ptukey`, `qtukey`                                           |
| Birthday          | `pbirthday`, `qbirthday`                                     |

------

### ⏱️ 时间序列

| 函数                                                         | 说明                       |
| ------------------------------------------------------------ | -------------------------- |
| `ts`                                                         | 创建时间序列对象           |
| `is.ts` / `is.mts`                                           | 判断是否为时间序列         |
| `start` / `end` / `time` / `cycle` / `frequency` / `deltat`  | 时间序列属性               |
| `lag`                                                        | 滞后                       |
| `diff`                                                       | 差分                       |
| `embed`                                                      | 时间序列嵌入               |
| `filter`                                                     | 线性滤波                   |
| `decompose`                                                  | 经典季节分解               |
| `stl`                                                        | STL 分解                   |
| `HoltWinters`                                                | Holt-Winters 滤波          |
| `StructTS`                                                   | 结构时间序列               |
| `ar` / `arima` / `arima.sim`                                 | AR/ARIMA 建模与模拟        |
| `acf` / `pacf` / `ccf`                                       | 自相关/偏自相关/互相关函数 |
| `spec.pgram` / `spec.ar`                                     | 谱密度估计                 |
| `cpgram`                                                     | 累积周期图                 |
| `convolve`                                                   | 卷积（FFT）                |
| `fft` / `mvfft`                                              | 快速傅里叶变换             |
| `KalmanForecast` / `KalmanLike` / `KalmanRun` / `KalmanSmooth` | 卡尔曼滤波                 |
| `window`                                                     | 时间序列窗口               |
| `ts.intersect` / `ts.union`                                  | 合并时间序列               |
| `tsdiag`                                                     | 时间序列诊断图             |
| `tsSmooth`                                                   | 固定区间平滑               |

------

### 🌳 聚类与树结构

| 函数                           | 说明               |
| ------------------------------ | ------------------ |
| `hclust`                       | 层次聚类           |
| `cutree`                       | 切割树为分组       |
| `cophenetic`                   | 共表距离           |
| `dendrogram` / `as.dendrogram` | 树状图             |
| `as.hclust`                    | 转换为 hclust 对象 |
| `rect.hclust`                  | 绘制聚类矩形       |
| `identify.hclust`              | 交互式识别聚类     |
| `dendrapply`                   | 对树节点应用函数   |
| `merge.dendrogram`             | 合并树状图         |
| `reorder.dendrogram`           | 重排树状图         |
| `kmeans`                       | K-Means 聚类       |
| `dist`                         | 距离矩阵计算       |

------

### 🔧 优化与数值计算

| 函数                     | 说明          |
| ------------------------ | ------------- |
| `optim`                  | 通用优化      |
| `optimise` / `optimize`  | 一维优化      |
| `constrOptim`            | 线性约束优化  |
| `nlm`                    | 非线性最小化  |
| `nlminb`                 | PORT 例程优化 |
| `integrate`              | 一维函数积分  |
| `uniroot`                | 一维求根      |
| `deriv` / `deriv3` / `D` | 符号/算法求导 |
| `numericDeriv`           | 数值求导      |
| `nextn`                  | 查找高合成数  |

------

### 📋 模型框架与公式

| 函数                                                         | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `formula` / `as.formula`                                     | 模型公式                                                     |
| `terms`                                                      | 模型项                                                       |
| `model.frame`                                                | 提取模型框架                                                 |
| `model.matrix`                                               | 构建设计矩阵                                                 |
| `model.response` / `model.offset` / `model.weights`          | 提取模型组件                                                 |
| `model.tables`                                               | aov 结果表                                                   |
| `reformulate`                                                | 构建公式                                                     |
| `update.formula`                                             | 更新公式                                                     |
| `offset`                                                     | 模型偏移项                                                   |
| `family`                                                     | GLM 族对象（`gaussian`, `binomial`, `poisson`, `Gamma`, `quasi` 等） |
| `contrasts` / `contr.treatment` / `contr.sum` / `contr.helmert` / `contr.poly` / `contr.SAS` | 对比矩阵                                                     |
| `poly` / `polym`                                             | 正交多项式                                                   |

------

### 📉 平滑与密度估计

| 函数                                                 | 说明                 |
| ---------------------------------------------------- | -------------------- |
| `density`                                            | 核密度估计           |
| `bw.nrd` / `bw.nrd0` / `bw.SJ` / `bw.bcv` / `bw.ucv` | 核密度带宽选择       |
| `loess` / `loess.control`                            | 局部多项式回归       |
| `lowess`                                             | 散点图平滑           |
| `smooth`                                             | Tukey 运行中位数平滑 |
| `smooth.spline`                                      | 平滑样条             |
| `supsmu`                                             | Friedman 超平滑      |
| `ksmooth`                                            | 核回归平滑           |
| `runmed`                                             | 运行中位数           |
| `smoothEnds`                                         | 端点平滑             |
| `stepfun`                                            | 阶跃函数             |
| `kernel` / `kernapply`                               | 平滑核对象           |

------

### 📊 列联表与分类数据

| 函数                   | 说明                 |
| ---------------------- | -------------------- |
| `xtabs`                | 交叉制表             |
| `ftable`               | 扁平列联表           |
| `addmargins`           | 添加边际             |
| `r2dtable`             | 给定边际的随机二维表 |
| `pairwise.prop.test`   | 成对比例比较         |
| `pairwise.t.test`      | 成对 t 检验          |
| `pairwise.wilcox.test` | 成对 Wilcoxon 检验   |

------

### 📐 多重比较与功效分析

| 函数               | 说明               |
| ------------------ | ------------------ |
| `p.adjust`         | P 值多重比较校正   |
| `TukeyHSD`         | Tukey 诚实显著差异 |
| `power.t.test`     | t 检验功效计算     |
| `power.prop.test`  | 比例检验功效计算   |
| `power.anova.test` | ANOVA 功效计算     |
| `se.contrast`      | 对比标准误         |
| `replications`     | 项的重复数         |

------

### 🖼️ 绘图函数

| 函数                            | 说明                |
| ------------------------------- | ------------------- |
| `plot.lm`                       | 线性模型诊断图      |
| `plot.ts`                       | 时间序列图          |
| `plot.acf`                      | ACF 图              |
| `plot.density`                  | 密度估计图          |
| `plot.ecdf`                     | 经验分布函数图      |
| `plot.hclust`                   | 层次聚类树状图      |
| `plot.prcomp` / `plot.princomp` | PCA 图              |
| `plot.spec`                     | 谱密度图            |
| `plot.HoltWinters`              | Holt-Winters 拟合图 |
| `plot.stl`                      | STL 分解图          |
| `biplot`                        | 双标图              |
| `heatmap`                       | 热力图              |
| `interaction.plot`              | 交互作用图          |
| `qqnorm` / `qqline` / `qqplot`  | Q-Q 图              |
| `lag.plot`                      | 滞后图              |
| `monthplot`                     | 季节子序列图        |
| `screeplot`                     | 碎石图              |
| `termplot`                      | 回归项图            |
| `cpgram`                        | 累积周期图          |
| `pairs.profile`                 | 剖面图              |

------

### 🧰 其他实用函数

| 函数                                              | 说明                                                         |
| ------------------------------------------------- | ------------------------------------------------------------ |
| `na.omit` / `na.exclude` / `na.fail` / `na.pass`  | 缺失值处理                                                   |
| `na.action` / `napredict` / `naprint` / `naresid` | NA 处理辅助                                                  |
| `ecdf`                                            | 经验累积分布函数                                             |
| `approx` / `approxfun`                            | 插值                                                         |
| `spline` / `splinefun`                            | 样条插值                                                     |
| `relevel` / `reorder`                             | 因子水平重排                                                 |
| `reshape`                                         | 数据重塑                                                     |
| `setNames`                                        | 设置名称                                                     |
| `symnum`                                          | 符号数字编码                                                 |
| `toeplitz`                                        | Toeplitz 矩阵                                                |
| `rWishart`                                        | 随机 Wishart 矩阵                                            |
| `selfStart`                                       | 自启动非线性模型（`SSasymp`, `SSlogis`, `SSfpl`, `SSgompertz`, `SSmicmen`, `SSweibull` 等） |
| `getInitial`                                      | 获取初始参数估计                                             |
| `printCoefmat`                                    | 打印系数矩阵                                                 |