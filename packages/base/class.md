# class

2026-09-04⭐
@author Jiawei Mao
***
## 描述

R 语言拥有一种简单的泛型函数（generic function）机制，可用于面向对象风格的编程。方法分派（Method dispatch）是基于泛型函数的第一个参数的类（class）来进行的。

```R
class(x)
class(x) <- value
unclass(x)
inherits(x, what, which = FALSE)
isa(x, what)

oldClass(x)
oldClass(x) <- value
.class2(x)
```

## 参数

- **x**：一个 R 对象。
- **what, value**：一个字符型向量，用于指定类的名称。`value` 也可以是 `NULL`。
- **which**：逻辑值（logical），用于控制返回值：详见“详细说明（Details）”部分。

## 详细说明

这里主要介绍所谓的“S3”类（和方法）。关于“S4”类（和方法），请参阅下文的“形式类（Formal classes）”部分。

许多 R 对象具有一个 `class` 属性，它是一个字符型向量，给出了该对象所继承的类的名称。（函数 `oldClass` 和 `oldClass<-` 分别用于获取和设置该属性，当然也可以直接进行操作）

如果对象没有 `class` 属性，则它具有一个隐式类（implicit class），通常为 `"matrix"`、`"array"`、`"function"` 或 `"numeric"`，或者是 `typeof(x)` 的结果（类似于 `mode(x)`）。但对于类型为 `"language"` 且模式为 `"call"` 的对象，针对相应的函数调用，存在以下额外的隐式类：`if`、`while`、`for`、`=`、`<-`、`(`、`{`、`call`。

请注意，对于具有隐式类（或 S4 类）的对象 `x`，当调用 (S3) 泛型函数 `foo(x)` 时，方法分派可能会使用比 `class(x)` 返回值更多的类。例如，对于一个数值型矩阵，可能会应用 `foo.numeric()` 方法。自 R 4.0.0 版本起，可以使用 `.class2(x)` 来获取 `UseMethod()` 所使用的完整类字符向量。（当考虑 S3 分派时，这也适用于 S4 对象，详见下文。）

> [!WARNING]
>
> 警告：除了用于教学、诊断或调试之外，不推荐使用 `.class2()`。

`NULL` 对象（其隐式类为 `"NULL"`）不能具有任何属性（因此也没有 `class` 属性），尝试为其赋值类将会引发错误。

当将泛型函数 `fun` 应用于具有类属性 `c("first", "second")` 的对象时，系统会首先寻找名为 `fun.first` 的函数，如果找到，则将其应用于该对象。如果未找到，则会尝试寻找名为 `fun.second` 的函数。如果没有任何类名能匹配到合适的函数，则会使用 `fun.default` 函数（如果存在的话）。如果没有 `class` 属性，系统会尝试使用隐式类，最后再尝试默认方法（default method）。

`class` 函数会打印出对象所继承的类名称向量。相应地，`class<-` 用于设置对象所继承的类。与 `oldClass<-` 或直接设置属性一样，赋值为空字符向量或 `NULL` 均可移除 `class` 属性。虽然显式赋值为 `NULL` 来移除类更为清晰，但在例如 `class(x) <- setdiff(class(x), "ts")` 这样的操作中，使用空向量显得更加自然。

`unclass` 返回其参数的一个副本，并移除该副本的 `class` 属性。（对于无法被复制的对象，即环境和外部指针，不允许使用此函数。）

`inherits` 用于指示其第一个参数是否继承了 `what` 参数中指定的任意类。如果 `which` 为 `TRUE`，则返回一个与 `what` 长度相同的整数向量。该向量中的每个元素表示 `what` 中对应元素在 `class(x)` 中匹配到的位置；`0` 表示没有匹配。如果 `which` 为 `FALSE`，只要 `what` 中的任何名称与任意类相匹配，`inherits` 就会返回 `TRUE`。

`isa` 用于测试 `x` 是否属于 `what` 中指定的类。如果 `x` 是 S4 对象，则使用 `is` 进行测试；否则，仅当 `class(x)` 的所有元素都包含在 `what` 中时才返回 `TRUE`。

除了 `inherits` 和 `isa` 之外，上述所有函数均为底层原生函数（primitive functions）。

## 形式类（Formal classes）

R 语言还提供了一种被称为“S4”的形式类（formal classes）附加机制，它包含在默认加载的 `methods` 包中。对于具有形式类的对象，`class` 函数会返回一个长度为 1 的字符型向量作为其类名，并且方法分派可以基于多个参数进行，而不仅仅是第一个参数。然而，S3 的方法选择机制会尝试将 S4 类的对象视为具有相应 S3 类属性的对象，`inherits` 函数的行为也是如此。因此，可以为 S4 类定义 S3 方法。有关 S4 方法的基础信息及其与 S3 方法的关系，请参阅帮助文档中的“Introduction（简介）”和“Methods_for_S3（S3 方法）”页面。

该函数的替换形式（赋值形式）会将对象的类设置为所提供的值。对于已有形式定义的类，强烈不建议使用这种方式直接替换类。应使用表达式 `as(object, value)` 将对象强制转换为特定的类。

对于形式类，与 `inherits` 函数相对应的是 `is` 函数。这两个函数的行为基本一致，但有一个例外：S4 类可以具有附带条件的继承关系（conditional inheritance），并带有显式的测试条件。在这种情况下，`is` 函数会测试该条件，而 `inherits` 则会忽略所有带有条件的父类（superclasses）。

## 注意

`oldClass` 和 `oldClass<-` 函数的行为与 S-PLUS 5/6 中同名函数的行为相同，但在 R 语言中，`UseMethod` 是基于 `class` 函数返回的类（包含一些插补的类：详见相关链接）来进行方法分派的，而不是基于 `oldClass`。不过，出于效率考虑，组泛型函数（group generics）是基于 `oldClass` 进行分派的，而内部泛型函数（internal generics）仅对 `is.object` 返回 `TRUE` 的对象进行分派。

## 示例

```R
x <- 10
class(x) # "numeric"
oldClass(x) # NULL
inherits(x, "a") #FALSE
class(x) <- c("a", "b")
inherits(x,"a") #TRUE
inherits(x, "a", TRUE) # 1
inherits(x, c("a", "b", "c"), TRUE) # 1 2 0

class( quote(pi) )           # "name"
## regular calls
class( quote(sin(pi*x)) )    # "call"
## special calls
class( quote(x <- 1) )       # "<-"
class( quote((1 < 2)) )      # "("
class( quote( if(8<3) pi ) ) # "if"

.class2(pi)               # "double" "numeric"
.class2(matrix(1:6, 2,3)) # "matrix" "array" "integer" "numeric"
```

