library(clusterProfiler)

d <- data.frame(gene.not.interest = c(2613, 15310),
                gene.in.interest = c(28, 29))
row.names(d) <- c("in_category", "not_in_category")

print(d)

fisher.test(d, alternative = "greater")