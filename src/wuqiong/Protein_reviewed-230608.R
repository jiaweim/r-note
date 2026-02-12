library(dplyr)
library(tidyr)

dir_input <- "D:\\data_friend\\wuqiong" # 输入目录
df_dia <- read.table(paste0(dir_input, "\\DIA.csv"), sep = ",", header = T, stringsAsFactors = F)
df_tmt <- read.table(paste0(dir_input, "\\TMT.csv"), sep = ",", header = T, stringsAsFactors = F)

colnames(df_dia) <- c("Proteins", "Gene.names") # 重命名标题
colnames(df_tmt) <- c("Proteins", "Gene.names")

human_reviewed <- read.delim(paste0(dir_input, "\\Human_reviewed_20421.txt"), sep = "\t", header = T, stringsAsFactors = F)
human_reviewed.v1 <- human_reviewed[, c(1, 2, 4, 5)] # Entry, Entry name, Protein names, Gene names

union_table.majotiry.protein.position <- function(total_table)
{
  #Majority.protein.ID first
  #total_table <- total_table[,c(17,1:16,18)]
  max_number <- max(unlist(lapply(total_table$Protein, function(x)length(unlist(strsplit(x, ";"))))))

  total_table2 <- separate(total_table, Protein, paste0("p", 1:max_number), sep = ";", remove = FALSE)

  p_number <- max_number + 1
  total_table2 <- gather(total_table2, proteinNO., Protein_single, 2:p_number, na.rm = TRUE)

}


Reviewed_protein_per_row_func <- function(st.v1 = df_dia) # DIA.csv, (Proteins, Gene.names)
{
  # 用 ; 拆分基因名（第二列）；保留第一个基因名
  st.v1$Gene.names.split <- sapply(st.v1$Gene.names, function(x) { unlist(strsplit(x, split = ";"))[1] })


  st.v1.protein <- data.frame(Protein = st.v1$Proteins, Gene_split = st.v1$Gene.names.split, Gene.names = st.v1$Gene.names,
                              index = seq(1, nrow(st.v1), by = 1), stringsAsFactors = F)


  st.v2.protein <- union_table.majotiry.protein.position(st.v1.protein)

  st.v2.protein$status <- "unreviewed"
  #st.v2.protein$status[st.v2.protein$Protein_single %in% human_reviewed.v1$Entry] = "reviewed"
  st.v2.protein$index.v2 <- seq(1, nrow(st.v2.protein), by = 1)

  st.combine <- st.v2.protein[1, , drop = F]
  st.combine[1,] <- NA

  for (i in 1:nrow(st.v1.protein))
  {
    st.single <- st.v2.protein[which(st.v2.protein$index == i), , drop = F]
    st.status <- unique(st.single$status)
    if ("reviewed" %in% st.status)
    {
      st.single.v1 <- st.single[st.single$status == "reviewed", , drop = F]
      st.single.v1 <- st.single.v1[1, , drop = F]
    }

    if (!("reviewed" %in% st.status))
    {
      st.single.v1 <- st.single[1, , drop = F]
    }

    st.combine <- rbind(st.combine, st.single.v1)
  }
  st.combine <- st.combine[-1,]

  st.v4 <- data.frame(Protein = st.combine$Protein_single, multi_protein = st.combine$Protein, Gene_split = st.combine$Gene_split, Gene_names = st.combine$Gene.names,
                      status = st.combine$status, Protein_number = st.combine$proteinNO., index = st.combine$index)

  #use gene_split to convert unreviewed ID to reviewed ID further.

  st.v4$Protein_v2 = st.v4$Protein
  st.v5 = st.v4[st.v4$status == "unreviewed", , drop = F]
  human_reviewed.v2 = human_reviewed.v1
  human_reviewed.v2$Gene_split = sapply(human_reviewed.v2$Gene.names, function(x) { unlist(strsplit(x, split = " "))[1] })
  human_reviewed.v2$Gene.names = NULL
  st.v6 = left_join(st.v5, human_reviewed.v2)


  st.v4 <- unique(st.v4)
  return(st.v4)
}

df_dia_v2_reviewed <- Reviewed_protein_per_row_func(st.v1 = df_dia)
df_tmt_v2_reviewed <- Reviewed_protein_per_row_func(st.v1 = df_tmt)

write.table(df_dia_v2_reviewed, file = paste0(dir_input, "\\DIA_v3_reviewed.txt"), sep = "\t", row.names = F, quote = F)
write.table(df_tmt_v2_reviewed, file = paste0(dir_input, "\\TMT_v3_reviewed.txt"), sep = "\t", row.names = F, quote = F)
