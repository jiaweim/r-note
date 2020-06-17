# SPSS/SAS/Stata 文件读写

## 简介

`haven` 包的 `read_sav()` 可以读取 SPSS 文件：

```r
# Only need to install the first time
install.packages('haven')

library(foreign)
data <- read_sav('datafile.sav')
```

`haven` 包还包含读取 SAS 和 Stata 文件的函数：

- `read_sas()`, SAS
- `read_dta()`, Stata

`foreign` 包也支持 SPSSS 和 Stata 文件，但是更新没有 `haven` 好。`foreign` 对 Stata 文件只支持到版本 12，而 `haven` 支持到了版本 14.

`foreign` 还支持一些其他格式，包括：

|函数|格式|
|---|---|
|`read.octave()`|MATLAB 和 Octave|
|`read.systat()`|SYSTAT|
|`read.xport()`|SAS XPORT|
|`read.dta()`|Stata|
|`read.spss()`|SPSS|
