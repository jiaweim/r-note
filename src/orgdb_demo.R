library(org.Hs.eg.db)

print(columns(org.Hs.eg.db))
print(keytypes(org.Hs.eg.db))

uniKeys <- head(keys(org.Hs.eg.db, keytype = "UNIPROT"))
cols <- c("SYMBOL", "PATH")
select(org.Hs.eg.db, keys = uniKeys, columns = cols, keytype = "UNIPROT")