# GenomicRanges

## 简介

GenomicRanges 用来处理基因组区间信息，如 genes, CpG, binding sites 等，同时还定义了用于存储和操作基因组区间的通用函数。

针对参考基因组的短序列比对的专业函数在 GenomicAlignments 和 SummarizedExperiment 包中。这两个包都建立在 GenomicRanges 基础上。

除了对 Granges 对象的基本操作，更重要的是对基因组间隔的处理，且对于单对象和多对象也有不同处理方式。

处理单对象的函数：

- reduce(), 合并各区域片段
- disjoin(), 将各区域片段切割为重复片段和未重复片段；
- flank(), 取 DNA 正链片段的上游 nbp，取 DNA 负链片段的下游 nbp，这种取法一般是为了找到该表达序列（基因）的启动子；
- coverage()，统计覆盖次数。

处理多对象的函数有 intersect(), union(), setdiff(), gap() 等。

## 功能演示

```r
# 创建 GRanges 对象
> gr <- GRanges(seqnames = Rle(c("chr1", "chr2"), c(2, 3)), ranges = IRanges(1:5, end = 6:10), strand = Rle(strand(c("-", "+", "+", "-")), c(1, 1, 2, 1)), score = 1:5, GC = seq(1, 0, length = 5))
> gr
GRanges object with 5 ranges and 2 metadata columns:
      seqnames    ranges strand |     score        GC
         <Rle> <IRanges>  <Rle> | <integer> <numeric>
  [1]     chr1       1-6      - |         1      1.00
  [2]     chr1       2-7      + |         2      0.75
  [3]     chr2       3-8      + |         3      0.50
  [4]     chr2       4-9      + |         4      0.25
  [5]     chr2      5-10      - |         5      0.00
  -------
  seqinfo: 2 sequences from an unspecified genome; no seqlengths
> length(gr)
[1] 5
> seqnames(gr)
factor-Rle of length 5 with 2 runs
  Lengths:    2    3
  Values : chr1 chr2
Levels(2): chr1 chr2
> start(gr)
[1] 1 2 3 4 5
> end(gr)
[1]  6  7  8  9 10
> ranges(gr)
IRanges object with 5 ranges and 0 metadata columns:
          start       end     width
      <integer> <integer> <integer>
  [1]         1         6         6
  [2]         2         7         6
  [3]         3         8         6
  [4]         4         9         6
  [5]         5        10         6
> gr[1:3]
GRanges object with 3 ranges and 2 metadata columns:
      seqnames    ranges strand |     score        GC
         <Rle> <IRanges>  <Rle> | <integer> <numeric>
  [1]     chr1       1-6      - |         1      1.00
  [2]     chr1       2-7      + |         2      0.75
  [3]     chr2       3-8      + |         3      0.50
  -------
  seqinfo: 2 sequences from an unspecified genome; no seqlengths
> c(gr[1], gr[3])
GRanges object with 2 ranges and 2 metadata columns:
      seqnames    ranges strand |     score        GC
         <Rle> <IRanges>  <Rle> | <integer> <numeric>
  [1]     chr1       1-6      - |         1       1.0
  [2]     chr2       3-8      + |         3       0.5
  -------
  seqinfo: 2 sequences from an unspecified genome; no seqlengths
```