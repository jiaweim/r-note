library(clusterProfiler)
data(geneList, package = "DOSE")
print(head(geneList))

#gene <- names(geneList)[abs(geneList) > 2]
#gene.df <- bitr(gene, fromType = "ENTREZID",
#                toType = c("ENSEMBL", "SYMBOL"),
#                OrgDb = org.Hs.eg.db)
#print(head(gene.df))