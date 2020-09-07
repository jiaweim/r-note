a <- c(2, 4, 3, 1, 5, 7)
for (i in seq_along(a)) {
  print(a[i] * 2)
}
a * 2

a[a > 2]