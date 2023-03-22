# Biostrings

## 简介

主要类：

- XString
  - BString，普通字符串类
  - DNAString, DNA 字符串类
  - RNAString, RNA 字符串类
  - AAString，蛋白质序列


`DNAString` 与 `BString` 主要差别在于 `DNAString` 只包含特定字符：A, T, C, G, -, N。

`XString` 与标准字符串向量的两个主要区别：

1. 存储在 `XString` 中的数据在复制对象时不复制；
2. 一个 `XString` 对象只能存储一个字符串


`XStringViews` 继承自 `Views`，用于存储同一条序列上的不同视图。每个视图包含子序列的起始点和终止点。

另外，`Biostrings` 还包含多个序列集合类：`XStringSet`，`BStringSet`, `DNAStringSet`, `RNAStringSet`, `AAStringSet`。

## 安装

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("Biostrings")
```

> 如果安装失败，可能是 Bioconductor 访问太慢，建议配置镜像。

## 函数



## 示例

```r
> d <- DNAString("TTGAAAA-CTC-N")

# 反向序列
> reverse(d)
13-letter DNAString object
seq: N-CTC-AAAAGTT

# 子序列
> subseq(d, 1, 5) # [1, 5]
5-letter DNAString object
seq: TTGAA
> subseq(d, start = 1) # [1, end]
13-letter DNAString object
seq: TTGAAAA-CTC-N
> subseq(d, end = 5) # [start, 5]
5-letter DNAString object
seq: TTGAA

# 字符串长度
> length(d)
[1] 13

# 统计所有字符频率
> alphabetFrequency(d)
A C G T M R W S Y K V H D B N - + . 
4 2 1 3 0 0 0 0 0 0 0 0 0 0 1 2 0 0 
# 统计 C 的频率
> letterFrequency(d, "C")
C 
2 
# 统计 C或G 的频率
> letterFrequency(d, "CG")
C|G 
  3 

> a <- DNAString("ACGTACGTACGC")
# 搜索特定字符串
> matchPattern("CGT", a)
Views on a 12-letter DNAString subject
subject: ACGTACGTACGC
views:
      start end width
  [1]     2   4     3 [CGT]
  [2]     6   8     3 [CGT]
# 允许 1 个字符错配
> matchPattern("CGT", a, max.mismatch = 1)
Views on a 12-letter DNAString subject
subject: ACGTACGTACGC
views:
      start end width
  [1]     2   4     3 [CGT]
  [2]     6   8     3 [CGT]
  [3]    10  12     3 [CGC]
> m <- matchPattern("CGT", a, max.mismatch = 1)
> start(m) # views 的开始位置
[1]  2  6 10
> end(m) # views 的结束位置
[1]  4  8 12
> length(m)
[1] 3
> countPattern("CGT", a, max.mismatch = 1)
[1] 3

> a <- DNAString("ACGTACGTACGC")
> dict0 <- PDict(c("CGT", "ACG"))
> mm <- matchPDict(dict0, a)
> mm[[1]]
IRanges object with 2 ranges and 0 metadata columns:
          start       end     width
      <integer> <integer> <integer>
  [1]         2         4         3
  [2]         6         8         3

# 匹配 PWM
> a <- DNAString("ACGTACGTACTC")
> motif <- matrix(c(0.97, 0.01, 0.01, 0.01, 0.1, 0.5, 0.39, 0.01, 0.01, 0.05, 0.5, 0.44), nrow = 4)
> rownames(motif) <- c("A", "C", "G", "T")
> motif
  [,1] [,2] [,3]
A 0.97 0.10 0.01
C 0.01 0.50 0.05
G 0.01 0.39 0.50
T 0.01 0.01 0.44
> matchPWM(motif, a)
Views on a 12-letter DNAString subject
subject: ACGTACGTACTC
views:
      start end width
  [1]     1   3     3 [ACG]
  [2]     5   7     3 [ACG]
  [3]     9  11     3 [ACT]
> countPWM(motif, a)
[1] 3

# Views 的基本操作
> a <- DNAString("ACGTACGTACTC")
> a2 <- Views(a, start = c(1, 5, 8), end = c(3, 8, 12))
> a2
Views on a 12-letter DNAString subject
subject: ACGTACGTACTC
views:
      start end width
  [1]     1   3     3 [ACG]
  [2]     5   8     4 [ACGT]
  [3]     8  12     5 [TACTC]
> subject(a2)
12-letter DNAString object
seq: ACGTACGTACTC
> length(a2)
[1] 3
> start(a2)
[1] 1 5 8
> end(a2)
[1]  3  8 12
> alphabetFrequency(a2, baseOnly=TRUE)
     A C G T other
[1,] 1 1 1 0     0
[2,] 1 1 1 1     0
[3,] 1 2 0 2     0
> a2 == DNAString("ACGT")
[1] FALSE  TRUE FALSE

# stringset 基本操作
> a <- DNAString("ACGTACGTACTC")
> a2 <- DNAStringSet(a, start = c(1, 5, 9), end = c(4, 8, 12))
> a2
DNAStringSet object of length 3:
    width seq
[1]     4 ACGT
[2]     4 ACGT
[3]     4 ACTC
> a2[[1]]
4-letter DNAString object
seq: ACGT
> alphabetFrequency(a2, baseOnly = TRUE)
     A C G T other
[1,] 1 1 1 1     0
[2,] 1 1 1 1     0
[3,] 1 2 0 1     0
```

## 参考

- https://www.rdocumentation.org/packages/Biostrings/versions/2.40.2
