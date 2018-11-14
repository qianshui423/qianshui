# MongoDB 学习记录

## 目标

#### 学会MongoDB的搭建

1. 搭建简单的单机服务
2. 搭建具有容错功能的复制集
3. 搭建大规模数据集群
4. 完成集群的自动部署

#### 熟悉MongoDB的使用

1. 最基本的文档的读写更新删除
2. 各种不同类型的索引的创建与使用
3. 复杂的聚合查询
4. 对数据集合进行分片，在不同分片间维持数据均衡
5. 数据备份与恢复
6. 数据迁移

#### 简单运维

1. 部署MongoDB集群
2. 处理多种常见的故障：  
>>单节点失效，如何恢复工作  
>>数据库被意外杀死如何进行数据恢复  
>>数据库发生拒绝服务时如何排查原因  
>>数据库磁盘快满时如何处理  

## 创建用户和库

#### 添加一个 userAdminAnyDatabase 用户, 超级管理员

```shell

# 打开mongo shell
$ mongo

# 添加超级管理账号
\> use admin  # 进入admin表
\>db.createUser(
     {
       user:"admin",
       pwd:"admin",
       roles:[{role:"root",db:"admin"}]
     }
)

# 查看用户是否创建成功
\> db.auth('admin', 'auth')
\> show users
```

附录：mongodb的权限:（https://docs.mongodb.com/manual/reference/built-in-roles/#database-user-roles）
1. 数据库用户角色：read、readWrite
2. 数据库管理角色：dbAdmin、dbOwner、userAdmin
3. 集群管理角色：clusterAdmin、clusterManager、clusterMonitor、hostManager
4. 备份恢复角色：backup、restore
5. 所有数据库角色：readAnyDatabase、readWriteAnyDatabase、userAdminAnyDatabase、dbAdminAnyDatabase
6. 超级用户角色：root
// 这里还有几个角色间接或直接提供了系统超级用户的访问（dbOwner 、userAdmin、userAdminAnyDatabase）
7. 内部角色：__system

#### 创建数据库

```shell
# 打开mongo shell
$ mongo

# 创建 dengyin 数据库
\> use dengyin

# 查看当前数据库
\> db

# 查看数据库列表
\> show dbs

# 为单个数据库添加管理用户
\> db.createUser({
    user: 'dengyin',
    pwd: 'dengyin',
    roles: [ { role: "readWrite", db: "dengyin" } ]
})
```

## 索引

#### 索引的种类

1. _id索引
2. 单键索引
3. 多建索引
4. 复合索引
5. 过期索引
6. 全文索引
7. 地理位置索引

#### _id索引

1. _id索引是绝大多数集合默认建立的索引
2. 对于每个插入的数据，MongoDB都会自动生成一条唯一的_id字段

#### 单键索引

1. 单键索引是最普通的索引
2. 与_id索引不同，单键索引不会自动创建

#### 多键索引

1. 多键索引与单键索引创建形式相同，区别在于字段的值
>>单键索引：值为单一的值，例如字符串、数字或者日期  
>>多键索引：值具有多个记录，例如数组

#### 复合索引

1. 当查询条件不只有一个时，就需要建立复合索引

```shell
# 查看find消耗的时间：
db.collection.find({x:2}).explain("executionStats")
```

#### 过期索引

1. 过期索引：是在一段时间后会过期的索引
2. 在索引过期后，相应的数据会被删除
3. 这适合存储一些在一段时间之后会失效的数据，比如用户的登录信息、存储的日志
4. 建立方法：

```shell
db.collection.createIndex({time: 1}, {expireAfterSeconds: 10})
```

过期索引的限制：

1. 存储在过期索引字段的值必须是指定的时间类型。说明：必须是ISODate或者ISODate数组，不能使用时间戳，否则不能被自动删除。
2. 如果指定了ISODate数组，则按最小的时间进行删除。
3. 过期索引不能是复合索引。
4. 删除时间是不精确的。说明：删除过程由后台程序每60s跑一次，而且删除也需要一些时间，所以存在误差。

#### 全文索引

1. 全文索引：对字符串和字符串数组创建全文可搜索的索引，一个集合只允许创建一个全文索引
2. 适用情况：{author: "", title: "", article: ""}
4. 建立方法：

```shell
db.collection.createIndex({key: "text"})
db.collection.createIndex({key_1: "text", key_2: "text"})
db.collection.createIndex({"$**": "text"})
```

5. 查询方法：

```shell
# 多个关键字或逻辑可以用空格分开(搜索包含coffee或者apple的记录)
db.collection.find({$text: {$search: "coffee apple"}})
# 关键字前加负号表示不包含该关键字(搜索包含coffee但不包含apple的记录)
db.collection.find({$text: {$search: "coffee -apple"}})
# 多个关键字与逻辑除了空格分开还要用双引号，并使用\转义(搜索既包含coffee又包含apple的记录)
db.collection.find({$text: {$search: "\"coffee\" \"apple\""}})
```

6. 全文索引相似度

>>$meta操作符：{score: {$meta: "textScore"}}  
>>写在查询条件后面就可以返回结果的相似度  
>>与sort一起使用，可以达到很好的实用效果

```shell
# 示例
db.collection.find({$text: {$search: "coffee apple"}}, {score: {$meta: "textScore"}})
# 按相似度排序
db.collection.find({$text: {$search: "coffee apple"}}, {score: {$meta: "textScore"}}).sort({score: {$meta: "textScore"}})
```

7. 全文索引使用限制

>>每次查询只能指定一个$text查询  
>>$text查询不能出现在$nor查询中  
>>查询中如果包含了$text，hint不再起作用  
>>3.2版本以后添加了对中文索引的支持

8. 索引属性

```shell
# 索引的格式（第一个参数-索引的值，第二个参数-索引的属性）
db.collection.createIndex({param}, {param})
```

比较重要的属性：名字、唯一性、稀疏性、是否定时删除

```shell
# 名字， name指定
db.collection.createIndex({}, {name: ""})
# 唯一性，unique指定
db.collection.createIndex({}, {unique: true/false})
# 稀疏性，sparse指定
db.collection.createIndex({}, {sparse: true/false})
# 是否定时删除，expireAfterSeconds指定 - TTL，过期索引
db.collection.createIndex({}, {expireAfterSeconds: 10})
```


#### 地理位置索引

1. 概念：将一些点的位置存储在MongoDB中，创建索引后，可以按照位置来查找其他点
2. 分类：
>>2d索引，用于存储和查找平面上的点  
>>2dsphere索引，用于存储和查找球面上的点

##### 2D索引：平面地理位置索引

1. 创建方式

```shell
db.collection.createIndex({w: "2d"})
```

备注：位置表示方式，经纬度[经度, 纬度];取值范围，经度[-180, 180]，纬度[-90, 90]

2. 查询方式

>>$near查询：查询距离某个点最近的点  
>>$geoWithin查询：查询某个形状内的点

near查询：

```shell
# near查询
db.collection.find({w: {$near: [1, 1], $maxDistance: 10}})
```

geoWithin查询：

预备知识：
>>$box：矩形，使用{$box: [[&#60;x1&#62;, &#60;y1&#62;], [&#60;x2&#62;, &#60;y2&#62;]]}  
>>$center：圆形，使用{$center: [[&#60;x1&#62;, &#60;y1&#62;], r]}  
>>$polygon：矩形，使用{$polygon: [[&#60;x1&#62;, &#60;y1&#62;], [&#60;x2&#62;, &#60;y2&#62;], [&#60;x3&#62;, &#60;y3&#62;]}

```shell
# geoWithin查询
db.collection.find({w: {$geoWithin: {$box: [[1, 1], [3, 3]]}}})
```

geoNear查询：

```shell
# geoNear查询
db.runCommand({
  geoNear: <collection>,
  near: [x, y],
  minDistance: 10(对2d索引无效),
  maxDistance: 10,
  num: ...
})
```

##### 2Dsphere索引：球面地理位置索引

1. 概念：球面地理位置索引
2. 创建方式：

```shell
db.collection.createIndex({w: "2dsphere"})
```

3. 位置表示方式：

GeoJSON：描述一个点，一条直线，多边形形状

```shell
# 格式
{type: "", coordinates: [<coordinates>]}
```

查询方式与2d索引查询方式类似，支持$minDistance与$maxDistance

#### 索引构建情况分析

1. 索引的优势：加快索引相关的查询
2. 索引的劣势：增加磁盘空间消耗，降低写入性能
3. 如何评判当前索引构建情况：
>>mongostat工具介绍   
>>profile集合介绍  
>>日志介绍  
>>explain分析

## MongoDB安全

1. MongoDB安全概览
2. 物理隔离与网络隔离
3. IP白名单隔离
4. 用户名密码鉴权

#### MongoDB安全概览

1. 最安全的是物理隔离：不现实
2. 网络隔离其次
3. 防火墙隔离再其次
4. 用户名密码最后