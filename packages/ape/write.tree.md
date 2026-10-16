# write.tree

@since 2026-10-16⭐
@author Jiawei Mao
***

将一棵树以 Newick 格式写入文件。

```r
write.tree(phy, file = "", append = FALSE,
           digits = 10, tree.names = FALSE)
```

## 参数

### phy

`"phylo"` 或 `"multiPhylo"` 对象。

### file

文件名（字符串）；如果 `file = ""`（默认），则输出到即控制台。

### append

逻辑值：

- `TRUE`，把树追加到文件末尾，不清除文件中已有数据；
- `FALSE`（默认）覆盖文件。

### digits

数值，输出枝长（branch lengths）的有效数字位数；负数不输出枝长。

### tree.names

逻辑值或字符向量：

- `TRUE`，在每棵树前写入树名；
- 字符向量，定义写入文件的树名。

## 详细说明

节点标签（node labels）与根枝长度（root edge length，若有）会一并写入文件。

如果 `tree.names == TRUE`，则输出一种 Newick 格式的变体：其中树的名称位于 Newick 格式树（括号会在事先被删除）的前面。树的名称取自 `names` 属性（如果存在的话）（当 `tree.names` 为字符串向量时，它们会被忽略）。

末端标签（tip labels）（以及节点标签，如果存在的话）在打印前会被检查：前导和尾随的空格、前导的左括号以及尾随的右括号会被删除；其余的空格会被替换为下划线；逗号、冒号、分号以及其他括号会被替换为破折号。

参数 `digits` 给出的是有效数字的位数（而非四舍五入）。例如，若 `digits = 2`，则枝长 `1.234e-7` 会被打印为 `1.23e-7`（而不是 0）。

## 返回值

如果 `file = ""`，返回一个 character 类型的向量；否则返回无（不可见的 `NULL`）。

## 另见

`read.tree`、`read.nexus`、`write.nexus`、`write.phyloXML`