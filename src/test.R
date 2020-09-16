a <- c('b', 'a', 'c', 'a')

l <- c("c", 'b', 'a')

b <- factor(a, levels = l)

print(levels(b))

