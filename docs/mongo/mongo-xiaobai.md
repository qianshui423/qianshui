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
（1）单节点失效，如何恢复工作  
（2）数据库被意外杀死如何进行数据恢复  
（3）数据库发生拒绝服务时如何排查原因  
（4）数据库磁盘快满时如何处理  

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