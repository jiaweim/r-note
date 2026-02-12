a <- c("a", "b", "c", "c", "d", "a")

b <- factor(a)

y <- c()
for (x in levels(b)) {
  count <- sum(a == x)
  y <- append(y, count)
  # print(x); print(count)
}
print(y)
