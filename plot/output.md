# 保存图

- [保存图](#保存图)
  - [简介](#简介)
  - [pdf](#pdf)
  - [PNG 输出](#png-输出)

2020-08-12, 12:54
***

## 简介

## pdf

用 `pdf()` 函数可以输出到 PDF 文件。

```r
pdf(file = if(onefile) "Rplots.pdf" else "Rplot%03d.pdf",
    width, height, onefile, family, title, fonts, version,
    paper, encoding, bg, fg, pointsize, pagecentre, colormodel,
    useDingbats, useKerning, fillOddEven, compress)
```

|参数|说明|
|---|---|
|file|输出文件路径|

例如：

```r
pdf(file = if(onefile) "Rplots.pdf" else "Rplot%03d.pdf",
    width, height, onefile, family, title, fonts, version,
    paper, encoding, bg, fg, pointsize, pagecentre, colormodel,
    useDingbats, useKerning, fillOddEven, compress)
```

`dev.off()` 关闭当前设备，并生成输出文件。

## PNG 输出

```r
png(file='fig-hw.png', height=1000, width=1000)
with(d.class, plot(height, weight,
                   main='体重与身高关系'))
dev.off()
```

类似的，用 `jpeg()` 函数启用 JPEG 图形设备，用 `bmp()` 启用 BMP 图形设备，用 `postscript()` 启用 PostScript 图形设备。
