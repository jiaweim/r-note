v1 <- c(5, 9, 3)
v2 <- c(10, 11, 12, 13, 14, 15)
# 创建数组
ar1 <- array(c(v1, v2), dim = c(3, 3, 2))
print(ar1)

# 计算数组中所有矩阵数值之和
print(apply(ar1, 3, sum))