# 100 次试验，每次试验成功概率为 0.3，生成 10 个数，对应成功次数
results <- rbinom(10, size = 100, prob = .3)
print(results)

print(mean(results))

results <- rbinom(100, size = 100, prob = .3)
print(mean(results))

results <- rbinom(10000, size = 100, prob = .3)
print(mean(results))
