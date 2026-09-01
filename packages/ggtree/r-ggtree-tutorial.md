# 使用 ggtree 对系统发育树进行可视化与注释

下面演示使用 `ggtree`（`ggplot2` 包的扩展包）来可视化和注释系统发育树（phylogenetic trees）。`ggtree` 是 `ggplot2` 的一个扩展插件。本文的许多示例均改编自 `ggtree` 的官方使用指南（vignettes）。

阅读本文需要你具备 R 语言的基础知识，熟悉数据框（data frames），掌握使用 `dplyr` 和 `%>%`（管道操作符）进行数据操作，最重要的是，熟悉使用 `ggplot2` 进行数据可视化。

这里**不涉及**生成系统发育树的方法和软件，也不解读系统发育树。全基因组测序使得对整个基因组进行检测成为可能；基于此，目前已有许多方法和软件工具，能够利用未组装的测序序列（reads）、草图组装/重叠群（contigs）或完整的基因组序列，通过基于 SNP 或基于基因的系统发育分析来进行比较基因组学研究。

## ggtree 软件包

`ggtree` 是一个 R 语言软件包，它扩展了 `ggplot2` 的功能，用于可视化系统发育树，并利用协变量及其他相关数据对其进行注释。该软件包可从 Bioconductor 获取：

- **ggtree Bioconductor 页面**：bioconductor.org/packages/ggtree
- **ggtree 主页**：guangchuangyu.github.io/ggtree （包含许多关于该软件包的信息、更多文档、精美图片集以及相关资源的链接）
- **ggtree 相关论文**：Yu, Guangchuang, et al. “ggtree: an r package for visualization and annotation of phylogenetic trees with their covariates and other associated data.” *Methods in Ecology and Evolution* (2016) DOI:10.1111/2041-210X.12628

Bioconductor 软件包通常都配有非常详尽的文档，形式为 vignettes（指南文档）。您可以查看 ggtree 的操作教程，其中包含了许多可运行的示例和解释。

就像来自 CRAN 的 R 软件包一样，Bioconductor 软件包也只需安装一次（安装说明在此），然后在每次启动新的 R 会话时加载即可。请先加载 `tidyverse` 软件包。

```r
library(tidyverse)
library(ggtree)
```

> [!NOTE]
>
> 在加载 `tidyverse` 之后再加载 `ggtree` 时，请花点时间查看一下输出信息。初次安装 `ggtree` 时可能会花费一些时间，因为它依赖于许多其他的 R 软件包。而这些软件包反过来又可能依赖于其他软件包。当加载 `ggtree` 时，它们都会被加载到您的工作环境中。同时请注意那些以 `The following objects are masked from 'package:....` 开头的行。其中一个例子是来自 `dplyr` 的 `collapse()` 函数。当 `ggtree` 被加载时，它也加载了自己名为 `collapse()` 的函数。现在，如果您想使用 `dplyr` 的 `collapse` 函数，您将不得不使用类似 `dplyr::collapse()` 这样的语法来显式调用它。



## 参考

- https://4va.github.io/biodatasci/r-ggtree.html