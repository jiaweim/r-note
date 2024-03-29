# R 绘图

## 简介

R语言的前身是S语言，S语言设计的目的就是交互式数据分析、绘图。所以绘图是R的重要功能。

R 自带从S语言继承的基本绘图功能， 还有一些功能更易用、更强大的绘图系统， 如lattice、ggplot2。 基本绘图使用简单，灵活性强，但是为了做出满意的图形需要比较多的调整。下面先讲解R语言的基本绘图功能。

R的基本绘图功能有两类图形函数：

- 高级图形函数， 直接针对某一绘图任务作出完整图形；
- 低级图形函数，在已有图形上添加内容。

具备有限的与图形交互的能力（函数locator 和identify）。

## 保存

将绘图语句放在开启和关闭目标图形设备的语句之间，实现保存图形到文件的功能。

- 即先使用 pdf(), png(), jpeg(), bmp(), tiff(), xfig() 和 postscript() 等函数启动图形设备驱动并创建文件
- 最后使用 dev.off() 关闭图形设备并输出返回到终端
- 也可以使用 dev.new(), dev.next(), dev.prev(), dev.set() 同时打开多个图形窗口

```r
# 创建 pdf
> pdf("mygraph.pdf")
# 添加数据集
> attach(mtcars)
# 绘图
> plot(wt, mpg)
# 拟合线
> abline(lm(mpg~wt))
# 添加标题
> title("Regression of MPG on Weight")
# 移除数据集
> detach(mtcars)
# 关闭设备
> dev.off()
```

## 参数设置

使用 `par()` 修改图形参数，这种方式针对所有图形。

不加参数执行生成包含当前图形参数设置的 list，添加 `no.readonly=TRUE` 生成可以修改的参数列表。

另外，大部分高级绘图函数，如 plot(), hist(), boxplot() 等，都可以自行设置坐标轴和文本标注。

- title() 设置标题和坐标轴标签
- axis() 创建自定义坐标轴
- abline() 为图形添加参考线
- legend() 添加图例
- text() 和 mtext() 向绘图区或图形边界添加文本

| 参数 | 说明 |
|--|--|
| pch | 指定绘制点时使用的符号 |
| lty | 指定线条类型 |
| lwd | 指定线条宽度,以默认值的相对大小表示 |
| col | 默认的绘图颜色。某些函数可接收一个含有颜色值的向量并自动循环使用 |
| col.axis | 坐标轴刻度文字的颜色 |
| col.lab | 坐标轴标签名称的颜色 |
| col.main | 标题颜色 |
| col.sub | 副标题颜色 |
| fg | 图形的前景色 |
| bg | 图形的背景色 |
| cex | 指定符号、文字等的大小。cex是一个数值，表示绘图符号相对于默认大小的缩放倍数。默认大小为1,1.5表示放大为默认大小的1.5倍 |
| cex.axis | 坐标轴刻度文字的缩放倍数 |
| cex.lab | 坐标轴标签名称的缩放倍数 |
| cex.main | 标题的缩放倍数 |
| cex.sub | 副标题的缩放倍数 |
| font | 用于指定绘图使用的字体样式,整数。1=常规,2=粗体,3=斜体,4=粗斜体,5=符号字体 |
| font.axis | 坐标轴刻度文字的字体样式 |
| font.lab | 坐标轴标签名称的字体样式 |
| font.main | 标题的字体样式 |
| font.sub | 副标题的字体样式 |
| ps | 字体磅值，文本的最终大小为ps*cex |
| family | 绘制文本时使用的字体族。标准的取值为serif(衬线)sans(无村线)和mono(等宽) |
| pin | 以英寸表示的图形尺寸(宽和高) |
| mai | 以数值向量表示的边界大小,顺序为“下、左、上、右”,单位为英寸 |
| mar | 以数值向量表示的边界大小,顺序为“下、左、上、右”,单位为英分 |


