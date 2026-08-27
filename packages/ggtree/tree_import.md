# 导入 tree 数据

## 1 系统发育树构建概述

系统发育树用于描述一组生物体之间的谱系（或亲缘）关系，通常可基于这些生物体的基因序列来构建。如图 1.1 所示，有根系统发育树通过节点之间的祖先-后代关系，以及在不同亲缘关系层级上“姐妹”或“旁系”生物体的聚类，来描绘进化历史的模型。在传染病研究中，系统发育树通常基于病原体的基因或基因组序列来构建，用以展示不同病原体样本之间的遗传相似程度（即哪些样本在遗传上更为接近）。这有助于我们深入了解潜在的、未被观察到的流行病学关联，并追溯疫情的潜在来源。”

![Components of a phylogenetic tree. External nodes (green circles), also called ‘tips’, represent actual organisms sampled and sequenced (e.g., viruses in infectious disease research). They are the ‘taxa’ in the terminology of evolutionary biology. The internal nodes (blue circles) represent hypothetical ancestors for the tips. The root (red circle) is the common ancestor of all species in the tree. The horizontal lines are branches and represent evolutionary changes (gray number) measured in a unit of time or genetic divergence. The bar at the bottom provides the scale of these branch lengths.](./images/phylogeny-1.svg)

> **图 1.1：系统发育树的组成**
>
> 外部节点（绿色圆圈）也被称为“末端（tips）”，代表实际被采样和测序的生物体（例如在传染病研究中的病毒）。在进化生物学术语中，它们被称为“分类单元（taxa）”。内部节点（蓝色圆圈）代表末端节点的假想祖先。根节点（红色圆圈）则是树中所有物种的共同祖先。水平线称为“分支（branches）”，代表以时间单位或遗传分化程度来衡量的进化改变（灰色数字）。底部的横条（比例尺）提供了这些分支长度的标度。”