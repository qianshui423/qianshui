两本好书：
1. http://javascript.ruanyifeng.com/
2. http://es6.ruanyifeng.com/

# 变量

1. 如果变量只声明而没有赋值，则该变量的值为undefined
2. 不使用var声明变量时，其为全局变量
3. 变量提升：JavaScript引擎的工作方式是，先解析代码，获取所有被声明的变量，然后再一行一行地运行。只对var声明的变量有效

# 标识符

1. JavaScript语言的标识符对大小写敏感

# 条件语句

1. switch语句后面的表达式与case语句后面的表达式，在比较运行结果时，采用的是严格相等运算符（===），而不是相等运算符(==)，这意味着比较时不会发生类型转换

# 标签

1. 不做介绍，不建议使用

# 强制转换

## Number()

### 原始类型值的转换规则

1.Number和parseInt：Number函数将字符串转换为数值，要比parseInt函数严格很多。基本上，只要有一个字符无法转换成数值，整个字符串就会被转换为NaN。parseInt逐个解析字符，Number整体转换字符串的类型。Number函数会自动过滤一个字符串前导和后缀的空格

### 对象的转换规则

1. Number方法的参数时对象时，将返回NaN，除非是包含单个数值的数组

2. valueOf  toString：对象的valueOf方法优先于toString方法执行

## String()

### 原始类型值的转换规则

1. 数值：转换为相应的字符串；字符串：还是原值；布尔值：true－"true"，false－"false"；undefined-"undefined"；null－"null"

### 对象的转换规则

1. String方法的参数如果是对象，返回一个类型字符串；如果是数组，返回该数组的字符串形式

2. toString  valueOf：对象的toString方法优先于valueOf方法执行

## Boolean()

1. 除以下六个值的转换结果为false，其他的全部为true：undefined、null、-0、0或+0、NaN、''(空字符串)

# 自动转换

1. 将一个表达式转换为布尔值：expression ? true : false ; !! expression

2. 除了加法运算符有可能把运算子转换为字符串，其他运算符都会把运算子自动转换为数值，一元运算符也会把运算子转换成数值

# 错误处理机制

## Error对象

1. 语言标准，Error对象的实例必须有message属性，大多数JavaScript引擎，对Error实例还提供name和stack属性，分别表示错误的名称和错误的堆栈

## Error的6个派生对象

1. SyntaxError：解析代码时发生的语法错误
2. ReferenceError：引用一个不存在的变量时发生的错误
3. RangeError：当一个值超出有效范围时发生的错误
4. TypeError：变量或参数不是预期类型时发生的错误
5. URIError：URI相关函数的参数不正确时抛出的错误，主要涉及encodeURI()、decodeURI()、encodeURIComponent()、decodeURIComponent()、escape()和unescape()这六个函数
6. EvalError：eval函数没有被正确执行时，会抛出EvalError错误。该错误类型已经不再在ES5中出现了，只是为了保证与以前代码兼容，才继续保留

# 函数

1. JavaScript语言中称函数为第一等公民
2. 同时采用function命令和赋值语句声明同一个函数，最后总是采用赋值语句的定义
3. 根据ECMAScript的规范，不得在非函数的代码块中声明函数，最常见的情况就是if和try语句。但是，实际情况是各家浏览器往往并不报错，能够运行
4. 立即调用的函数表达式（IIFE）。通常情况下，只对匿名函数使用这种“立即执行的函数表达式”。它的目的有两个：一是不必为函数命名，避免了污染全局变量；二是IIFE内部形成了一个单独的作用域，可以封装一些外部无法读取的私有变量

# 数值

1. JavaScript 内部，所有数字都是以64位浮点数形式储存，即使整数也是如此。所以，1与1.0是相同的，是同一个数

2. 0.1 + 0.2 === 0.3  //false

3. 判断NaN更可靠的方法是，利用NaN是JavaScript之中唯一不等于自身的值这个特点，进行判断： value !== value

4. isFinite函数返回一个布尔值，检查某个值是不是正常数值，而不是Infinity

# 代码风格

1. 表示函数调用时，函数名与左括号之间没有空格。
2. 表示函数定义时，函数名与左括号之间没有空格。
3. 其他情况时，前面位置的语法元素与左括号之间，都有一个空格。



