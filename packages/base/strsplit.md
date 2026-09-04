# strsplit

分割字符向量。

```r
strsplit(x, split, fixed = FALSE, perl = FALSE, useBytes = FALSE)
```

使用子字符串 `split` 拆分字符向量 `x`。

## 参数

- **x**

字符向量，其中的每个元素都将被拆分。其它输入类型，包括 factor 都会抛出错误。

- **split**

包含用于分割的正则表达式（除非 `fixed = TRUE`）。如果出现空匹配，特别是 `split` 长度为 0，`x` 被拆分为单个字符。

- **fixed**

logical. `TRUE` 表示精确匹配 `split`，否则是哦也能够正则表达式。优先于 `perl`.

- **perl**

logical. 是否使用兼容 Perl 的正则表达式。

- **useBytes**

logical. `TRUE` 表示逐 byte 匹配，而非逐 character 匹配，并且不转换带标记编码的输入。如果发现任何带有 "bytes" 的标记的输入，此为强制选项。

## 返回值

返回长度与 `x` 相同的 list，list 的第 i 个元素包含 `x[i]` 的拆分向量。

