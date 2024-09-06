# 代码提速

## 向量化代码

向量化代码，指代码接受一个含有多个值的向量作为输入，同时操作向量的每一个元素。

例如：计算数值型向量中所有元素的绝对值

- 非向量化版本

```R
abs_loop <- function(vec){
  for(i in 1:length(vec)){
    if(vec[i] < 0){
      vec[i] <- -vec[i]
    }
  }
  vec
}
```

- 向量化版本

```R
abs_set <- function(vec){
  negs <- vec < 0
  vec[negs] <- vec[negs] * -1
  vec
}
```

`abs_set` 的速度要远快于 `abs_loop`，它使用了 R 的三大法宝：

1. 逻辑测试
2. 取子集
3. 逐元素执行

使用 `system.time` 查看这两个函数运行的速度。

首先，生成一个长度为 1000 万包含正数和负数的向量：

```r
> long <- rep(c(-1, 1), 5000000)
```

 然后，用 `system.time` 测试上面两个函数执行所需的时间：

```r
> system.time(abs_loop(long))
   user  system elapsed 
   0.12    0.00    0.36 
> system.time(abs_set(long))
   user  system elapsed 
   0.09    0.00    0.22 
```

`system.time` 输出结果的前两列分别为执行函数在用户层面和系统层面的耗时，不同操作系统会有所差别。

最后一列是 R 运行函数的实际时间（秒）。显然，`abs_set` 比 `abs_loop` 要快，如果进一步增加数据集规模，这个差别会更明显。

R 自带有计算绝对值的函数 `abs`，其速度更快：

```R
> system.time(abs(long))
   user  system elapsed 
   0.00    0.00    0.01 
```

## 编写向量化代码

R 中很多函数已经向量化，基于这些函数的代码很容易向量化。有两种方法：

1. 对有序步骤，使用向量化函数完成
2. 对同类情况，使用逻辑子集处理

> [!TIP]
>
> if 和 for
>
> if 语句只能应用于一个值，因此它经常与 for 循环同时出现。这样的组合经常可以被逻辑子集操作取代。

## 快速 for 循环

1. 能放在循环外的代码，不要放在循环内
2. 确保存储循环结果的对象具有足够容量

比如，先准备好存储所需容量：

```R
> system.time({
+   output <- rep(NA, 1000000)
+   for(i in 1:1000000){
+     output[i] <- i + 1
+   }
+ })
   user  system elapsed 
   0.00    0.00    0.01 
```

或者不准备：

```R
> system.time({
+   output <- NA
+   for(i in 1:1000000){
+     output[i] <- i + 1
+   }
+ })
   user  system elapsed 
   0.03    0.00    0.13 
```

两端代码实现功能相同，效率却相差很大。后者每次循环，都需要延长 `output` 以容纳新结果，因此需要不断复制 `output` 向量，在内存中删除原 `output`，再找新的地方存储该向量。因此，在循环结束时，`output` 已经在内存中反复重写了 100 万次。

> [!NOTE]
>
> R 的许多基本函数是使用 C 或 Fortran 等高性能语言实现的，当在函数源码中看到 .Primitive, .Internal 或 .Call 时，表示这些函数调用了其它语言编写的代码。

