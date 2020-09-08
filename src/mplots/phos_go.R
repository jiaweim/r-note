library(clusterProfiler)
library(ggplot2)
library(org.Hs.eg.db)
library(readr)

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

ego <- enrichGO(gene = entrez_id_list$ENTREZID,
                OrgDb = org.Hs.eg.db,
                ont = "all",
                pvalueCutoff = 0.01,
                qvalueCutoff = 0.05)

p <- barplot(ego, split = "ONTOLOGY") + facet_grid(ONTOLOGY ~ ., scale = 'free')
#ggsave("b.pdf")
