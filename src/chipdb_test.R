library(hgu95av2.db)

# 1st get some example keys
k <- head(keys(hgu95av2.db, keytype = "PROBEID"))
# then call select
select(hgu95av2.db, keys = k, columns = c("SYMBOL", "GENENAME"), keytype = "PROBEID")

mapIds(hgu95av2.db, keys = k, column = c("GENENAME"), keytype = "PROBEID")