# GenomicFeatures

## 简介

GenomicFeatures 包含一系列用于操作转录本注释信息的工具和方法。可以用来从 UCSC Genome Browser 或 BioMart 数据库下载特定生物的转录本、外显子和蛋白质编码序列的基因组位置。

转录组数据下载后，以 TxDb 数据库格式存储在本地。TxDb 文件包含 5 端和 3 端的非翻译区（UTR）、外显子（exons）、蛋白质编码序列（CDS）等。TxDb 对象允许以单独或组合的方式检索这些特征。

## 示例

以人类基因 h19 为例，实现其下载和相关操作。

首先是 TxDb 对象的建立和下载，可以选择从 UCSC 或 Biomart 数据库下载，也可以从 GFF3 或 GTF 文件导入，所用函数：

- makeTxDbFromUCSC() # 从 UCSC 数据库下载
- makeTxDbFromBiomart() # 从 Biomart 数据库下载
- makeTxDbFromGFF() # 使用 GFF3 或者 GTF 文件

