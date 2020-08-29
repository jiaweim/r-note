d <- data.frame(
  name = c("Lili", "Lucy", "Dog"),
  age = c(30, 35, 40),
  height = c(180, 175, 160),
  gender = c('F', "F", "M"),
  stringsAsFactors = FALSE
)
print(d[2, 3])
print(d[[2]])
print(d[, 2])
print(d[["name"]])
print(d[, "name"])
print(d$name)

x <- d[2,]
print(x)
print(is.data.frame(x))

print(d[1:2, "name"])
print(d[1:2, c("name", "age")])

print(d[d$age >= 35,])

print(d[, 2, drop = FALSE])
print(d[c("name", "age")])
print(d[, c("name", "age")])
print(d[1:2])

y <- d["name"]
print(y)
print(is.data.frame(y))

rownames(d) <- d$name
print(d)