# IRanges

- [IRanges](#iranges)
  - [简介](#简介)
  - [reverse](#reverse)
  - [参考](#参考)


## 简介

该包提供了高效的底层 S4 类，用于存储范围整数、RLE 向量（Run-Length Encoding）、序列数据（一般为 `Vector`）以及 `Vector` 上的视图。还提供高效的 list-like 类，用于存储基础类的对象实例。包中的类使用一致命名，并共享一致的 "Vector API"。

## reverse

用于翻转 vector-like 或 list-like 对象的通用函数。如字符向量、`Views` 对象，或者 `MaskCollection` 对象。`reverse` 类似 `rev`，但不安全相同。

对字符向量或 `Views` 对象，`reverse` 逐个翻转每个元素，但不修改顶层元素的顺序。即单独翻转字符向量的每个字符串。

```r
reverse(x, ...)
```

**参数：**

- `x`

vector-like 或 list-like 对象

- `...`

其它参数。

**返回：**

- 与原对象相同类型和长度的对象。

**示例：**

```r
# 字符向量
> reverse(c("Hi!", "How are you?")) # 逐个元素翻转
[1] "!iH"          "?uoy era woH"
> rev(c("Hi!", "How are you?")) # 对顶层元素逆序
[1] "How are you?" "Hi!"         

# Views 对象
> v <- successiveViews(Rle(c(-0.5, 12.3, 4.88), 4:2), 1:4)
> v
Views on a 9-length Rle subject

views:
    start end width
[1]     1   1     1 [-0.5]
[2]     2   3     2 [-0.5 -0.5]
[3]     4   6     3 [-0.5 12.3 12.3]
[4]     7  10     4 [12.30  4.88  4.88 ...]
> reverse(v)
Views on a 9-length Rle subject

views:
    start end width
[1]     9   9     1 [-0.5]
[2]     7   8     2 [-0.5 -0.5]
[3]     4   6     3 [12.3 12.3 -0.5]
[4]     0   3     4 [ 4.88  4.88 12.30 ...]
> rev(v)
Views on a 9-length Rle subject

views:
    start end width
[1]     7  10     4 [12.30  4.88  4.88 ...]
[2]     4   6     3 [-0.5 12.3 12.3]
[3]     2   3     2 [-0.5 -0.5]
[4]     1   1     1 [-0.5]
> mask1 <- Mask(mask.width = 29, start = c(11, 25, 28), width = c(5, 2, 2))
> mask2 <- Mask(mask.width = 29, start = c(3, 10, 27), width = c(5, 8, 1))
> mask3 <- Mask(mask.width = 29, start = c(7, 12), width = c(2, 4))
> mymasks <- append(append(mask1, mask2), mask3)
> reverse(mymasks)
MaskCollection of length 3 and width 29
masks:
  maskedwidth maskedratio active
1           9   0.3103448   TRUE
2          14   0.4827586   TRUE
3           6   0.2068966   TRUE
all masks together:
  maskedwidth maskedratio
           19   0.6551724
```

## 参考

- https://www.rdocumentation.org/packages/IRanges/versions/2.6.1
- https://github.com/Bioconductor/IRanges