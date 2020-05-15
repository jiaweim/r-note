# 向量

- [向量](#%e5%90%91%e9%87%8f)
  - [简介](#%e7%ae%80%e4%bb%8b)
  - [创建向量](#%e5%88%9b%e5%bb%ba%e5%90%91%e9%87%8f)
    - [创建时指定大小](#%e5%88%9b%e5%bb%ba%e6%97%b6%e6%8c%87%e5%ae%9a%e5%a4%a7%e5%b0%8f)
  - [元素命名](#%e5%85%83%e7%b4%a0%e5%91%bd%e5%90%8d)
  - [索引](#%e7%b4%a2%e5%bc%95)
    - [选择单个元素](#%e9%80%89%e6%8b%a9%e5%8d%95%e4%b8%aa%e5%85%83%e7%b4%a0)
    - [选择多个元素](#%e9%80%89%e6%8b%a9%e5%a4%9a%e4%b8%aa%e5%85%83%e7%b4%a0)
    - [选择连续元素](#%e9%80%89%e6%8b%a9%e8%bf%9e%e7%bb%ad%e5%85%83%e7%b4%a0)
    - [根据名称选择](#%e6%a0%b9%e6%8d%ae%e5%90%8d%e7%a7%b0%e9%80%89%e6%8b%a9)
  - [向量操作](#%e5%90%91%e9%87%8f%e6%93%8d%e4%bd%9c)

2020-05-14, 09:41
***

## 简介

向量，用于保存**相同类型数据**。R 中，单个数值没有单独的数据类型，而是作为向量的一种特例。

在R中，向量的大小在创建时已经确定，因此如果要添加或删除元素，需要重新给向量赋值。

## 创建向量

通过 `c()` 函数（表示连接，Concatenate），创建 Vector:

```r
# Create a vector
apple <- c('red', 'green', 'yello')
print(apple)

# get the class of the vector
print(class(apple))
```

输出：

```console
[1] "red"   "green" "yello"
[1] "character"
```

### 创建时指定大小

```r
y <- vector(length = 2)
```

## 元素命名

```r
names(roulette_vector) <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
```

为向量 `roulette_vector` 每个元素命名。

## 索引

### 选择单个元素

```r
> a <- c(1, 2, 5, 3)
> a[3]
[1] 5
```

### 选择多个元素

选择多个元素，如选择第1和5两个元素：

```r
a_vecotr[c(1, 5)]
```

### 选择连续元素

```r
a_vector[2:4]
```

等价于 `a_vector[c(2, 3, 4)]`

### 根据名称选择

```r
a_vector["Monday"]
```

## 向量操作

