# 导出图像

- [导出图像](#导出图像)
  - [简介](#简介)
  - [PDF](#pdf)
  - [ggsave](#ggsave)

2020-08-28, 13:21
@jiaweiM
***

## 简介

如果使用 Rmarkdown 制作图文，图像会自动进入编译的结果（PDF, Word, HTML）中，图像大小、输出大小可以用 Rmarkdown 的设置调整。

## PDF

PDF 是矢量文件格式，矢量文件是打印输出的首选格式，因为可以缩放到任意大小而不会模糊。矢量文件大小一般小于对应的位图文件，除非对象特别多。（例如，上千个散点图）

```r
pdf("plots.pdf")
plot(...)
plot(...)
dev.off()
```

PDF 默认为 7x7 英寸，每个新图都放在新的页面。

可以通过如下方式修改尺寸：

```r
# 6x3 inches
pdf("plots.pdf", width=6, height=3)

# 10x6 cm
pdf("plots.pdf", width=10/2.54, height=6/2.54)
```

如果要在其它软件（如 Inkscape 或 Illustrator）中编辑PDF文件，则推荐添加设置：

```r
pdf("plots.pdf", useDingbats=FALSE)
```

## ggsave

大多情况，使用 `ggsave` 是保存图像最简单的方式。对复杂的情形，可以打开 R 图形设备如 `png()`, `pdf()`，输出对应图像，然后使用 `dev.off()` 关闭设备。

```r
ggsave(
  filename,
  plot = last_plot(),
  device = NULL,
  path = NULL,
  scale = 1,
  width = NA,
  height = NA,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
  ...
)
```

`ggsave` 将最近的绘图导出为文件，根据文件路径扩展名识别导出格式。

参数说明：

1. filename

导出文件名称

2. plot

导出的 plot，默认为上次显示的 plot。

3. device

导出设备。可以为对应函数，如 `png()`，或者设备名称，如 `eps`, `ps`, `pdf`, `jpeg`, `tiff`, `png`, `bmp`, `svg` 或者 `wmf`。

4. path

导出文件目录：`path` 和 `filename` 合并起来构成完整路径，默认为工作目录。

5. scale

缩放比例。

6. width, height, units

plot 尺寸，单位包括 "in", "cm", "mm"。默认为当前图形设备大小。

7. dpi

分辨率。仅对栅格图像类型，支持格式有："retina"(320), "print"(300) 和 "screen"(72)。

8. limitsize

如果为 TRUE（默认），则 `ggsave` 不保存大于 50x50 英寸的图像，以防止常见的指定单位错误。

9. `...`

其他特定于 `device` 的参数。


将最近生成的图形保存为 PNG 格式：

```r
p <- ggplot(
  data = filter(gapminder, year == 2007),
  mapping = aes(
    x = gdpPercap,
    y = lifeExp,
    color = log(pop)
  )
)

pp <- p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10(labels = scales::dollar)

ggsave(filename = "scatter.png")
```

保存为 PDF：

```r
ggsave(filename="文件名.pdf")
```

也可以将制作的图形保存在变量中，然后使用 `plot=` 参数指定需要保存的图形：

```r
ggout01 <- p + geom_point()
ggsave(filename="文件名.pdf", plot=ggout01)
```

在 `ggsave()` 中可以用 `scale=` 指定放大比例，用 `height=` 指定高度，用 `width=` 指定宽度，用 `units=` 指定高度和宽度的单位。例如：

```r
ggsave(filename="文件名.pdf", plot=ggout01,
       height=12, width=8, units="cm")
```

可选单位有 in, cm, mm。
