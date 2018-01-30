https://docs.mongodb.com/master/tutorial/install-mongodb-on-os-x/  

https://docs.mongodb.com/master/tutorial/enable-authentication/  

https://docs.mongodb.com/manual/reference/program/mongos/index.html  


1. 连接远程mongo数据库
> mongo 192.168.1.200:27017/test -u user -p password

2. 查看当前数据库
> db

3. 查看当前库的所有表
> show collections

4. 选择数据库
> use myDB

5. 查看所有数据库
> show dbs

6. mongo层面的命令
> mongo —help()

7. db层面的命令
> help

8. 查看db的字命令
> db.help()

9. 查看对表的命令
> db.collection.help()

10. 登录远程数据库
> mongo --port 27017 -u "userName" -p "password" --authenticationDatabase "databaseName"

11. 开启数据库服务
> mongod --port 27017 --dbpath /data/db --auth --fork --logpath=log/mongodb.log
