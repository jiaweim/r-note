library(clusterProfiler)
library(org.Hs.eg.db)
library(readr)
library(enrichplot)

# read data
phos.data <- read_csv(file = "D:\\igd\\files\\kidney_offset307_phos_gene.csv",
                      col_types = cols(.default = col_character(),
                                       "hasPhospho" = col_logical()))
# only keep proteins with phospho modification
phos <- phos.data %>% filter(hasPhospho)
# convert gene symbol to entrez id, if use uniprot, the failed percentage is high
entrez_id_list <- bitr(phos$`Gene Name`,
                       fromType = "SYMBOL",
                       toType = "ENTREZID",
                       OrgDb = "org.Hs.eg.db")
geneList <- entrez_id_list$ENTREZID

kk <- enrichKEGG(gene = geneList,
                 organism = 'hsa', # hsa for human
                 pvalueCutoff = 0.01,
                 qvalueCutoff = 0.05)
p <- dotplot(kk)+ggtitle("KEGG")
ggsave("kegg.pdf")
#dotplot(kk, showCat)
#barplot(kk, showCategory = 8)
