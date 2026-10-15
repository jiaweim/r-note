# read.tree



读取一个包含一棵或多棵括号格式树的文件，即 Newick 或 New Hampshire 格式。

```R
read.tree(file = "", text = NULL, tree.names = NULL, skip = 0,
    comment.char = "", keep.multi = FALSE, ...)
```

## 参数

### file

文件名，由字符变量或双引号字符串指定；

如果 `file = ""`（默认），则从键盘输入树，空行结束。

### text

包含括号格式树的字符向量：

- `text` 默认为 `NULL`，表示从文件中读取树；
- `text` 不为 `NULL` 时，忽略 `file` 参数。

### tree.names

读取多棵树时，提供每棵树名称的字符向量；为 `NULL`（默认）时树将被命名为 "tree1", "tree2", ...

### skip

读取数据前跳过的行数（此参数直接传递给 `scan()`）。

### comment.char

单个注释字符，每行此字符后的内容被忽略（此参数直接传递给 `scan()`）。

### keep.multi

为 `TRUE` 时，且 `tree.names = NULL`，单棵树也以 `multiPhylo` 返回，并保留文件中的名称。默认为 `FALSE`。

### ...

传递给 `scan()` 的其他参数。

## 详细说明 

`file` 默认允许从键盘输入树，或从编辑器粘贴到 R 控制台，例如：`mytree <- read.tree()`。

`read.tree` 会尽量解析根分支出错的树（如多了一对括号）。例如，`"((A:1,B:1):10);"` 会按 `"(A:1,B:1):10;"` 读取，但会警告，因为前者不是有效的 Newick 格式。若有两个根分支，如 `"(((A:1,B:1):10):10);"`），则无法读取并报错。

如果某行第一个 `"("` 前有字符，这些字符将会作为树的名称；当返回 `multiPhylo` 对象且 `tree.names = NULL` 时，会返回这些名称。

在 ape 4.1 及更早版本中，`comment.char` 默认为 `"#"`（同 `scan`）；该默认设置已更改，以便读取扩展 Newick 文件。

## 返回值

返回 `phylo` 类对象，包含：

- **edge**：一个两列数值型矩阵，每行代表一条边；节点和末端（叶子）用数字表示；末端编号为 1, 2, ...，内部节点编号在末端之后。每行第一列代表祖先节点。
- **edge.length**（可选）：数值向量，`edge` 中各分支长度。
- **tip.label**：字符向量，末端节点名称；顺序与 `edge` 中的（正）编号对应。
- **Nnode**：内部节点数。
- **node.label**（可选）：字符向量，内部节点名称。
- **root.edge** （可选）：数值，根分支长度（若存在）。

如果从文件中读取多棵树，则返回 `multiPhylo` 类，即 `phylo` 对象列表。每棵树的名称可通过 `tree.names` 指定，也可以从文件中读取。

## 示例

