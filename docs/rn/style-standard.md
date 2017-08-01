# React Native Style样式命名

## 业界内的一些CSS命名规范

### 腾讯alloyteam团队前端CSS命名规范

- 类名使用小写字母，以中划线分隔
- id采用驼峰式命名

### 阿里巴巴前端CSS命名规范

- 变量名都需要有业务价值，以中划线分割的全小写命名

### 百度前端CSS命名规范

- 没有找到CSS命名相关的叙述
- 通过看示例代码，以中划线分割的全小写命名

## React Native Style命名

中划线分割的字母全小写命名(RN样式值是小驼峰命名)
小驼峰命名

### 一些使用场景

- 基本前提，一个Styles定义对应一个文件(建议单文件单Component)
- Normal样式＋组合样式(为了动态改变布局样式)
- 组件本身没有任何业务含义的样式命名，如container布局、分割线、小图标等

### 为什么希望style命名更易读？

三看

- 一看就知道它是什么组件
- 一看就知道它是什么业务含义
- 一看就知道它是什么状态

### 如何做到上述三个问题？

- 基本前提，一定要包含业务价值，不在JSX中直接写入样式内容
- 组件有业务含义的Style命名：组件类型-业务含义-状态

> 1. 组件类型：View、Text、ActivityIndicator等，采用首字母组合，v、t、ai。若单字母命名存在冲突，需全称小写代替；若组合字母命名存在冲突，则最后一个字母需全拼，如aIndicator；若再冲突，则共同商定
> 2. 业务含义：…，建议不要超过三个单词
> 3. 状态：Normal、Active，如果一个组件只有Normal态，可以省略不写

- 组件无业务含义的Style命名：组件类型-子业务含义-功能类型

> 1. 组件类型：同上1
> 2. 业务含义：...，建议不要超过三个单词
> 3. 功能类型：如Container，Separation，Icon

参考链接：

[腾讯alloyteam前端规范](https://www.kancloud.cn/digest/code-guide/42602)  
[阿里前端JavaScript规范](https://yq.aliyun.com/articles/51488)  
[百度前端CSS规范](https://github.com/ecomfe/spec/blob/master/css-style-guide.md)  