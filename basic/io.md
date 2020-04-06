# R IO

- [R IO](#r-io)
  - [键盘输入](#%e9%94%ae%e7%9b%98%e8%be%93%e5%85%a5)
  - [读取带分隔符的文本文件](#%e8%af%bb%e5%8f%96%e5%b8%a6%e5%88%86%e9%9a%94%e7%ac%a6%e7%9a%84%e6%96%87%e6%9c%ac%e6%96%87%e4%bb%b6)
  - [CSV](#csv)

## 键盘输入

edit() 函数自动调用一个允许手动输入输入的文本编辑器。步骤：

1. 创建一个空的数据框（或矩阵），并制定好变量名和变量的类型
2. 针对该数据调用文本编辑器，输入你的数据，并将结果保存回数据对象。
这种输入方式，对小数据集比较合适。

例：

```r
mydata <- data.frame(age = numeric(0),
                     gender = character(0),
                     weight = numeric(0))
mydata <- edit(mydata)
```

说明：

- `numeric(0)` 指定类型但不包含实际数据
- `edit()`的返回值需要赋值回原对象.edit() 在对象的副本上进行操作，如果不赋值回原目标，数据丢失。

运行，弹出一个输入框：

![table](images/2019-09-01-16-07-09.png)

输入完成后，关掉窗口，数据会自动保存到对象中。

## 读取带分隔符的文本文件

语法：

```r
mydataframe <- read.table(file, header=logical_value, sep="delimiter", row.names="name")
```

参数说明：

- file, 带分隔符的ASCII文本文件
- header，表面首行是否包含了变量名称
- sep, 指定分隔符
- row.names，可选参数，指定一个或多个表示行标识符的变量

字符型变量，默认读取为 factor类型，如果不希望如此，可以通过 read.table 的参数设置。

例如，读取CSV文件

```r
a_table <- read.table("io/input.csv", header = TRUE, sep = ",")
```

## CSV

读取 csv:

```r
data <- read.csv("input.csv")
print(data)
```

`read.csv` 返回的是 data frame 对象，
