### Ubuntu 16.04 Nginx环境配置

#### 安装Nginx依赖库

```shell
# 安装 gcc g++ 依赖库
apt-get install build-essential
apt-get install libtool
# 安装 pcre 依赖库
apt-get update
apt-get install libpcre3 libpcre3-dev
# 安装 zlib 依赖库
apt-get install zlib1g-dev
# 安装 ssl 依赖库
apt-get install openssl
```

#### 安装Nginx(http://nginx.org)

```shell
# 下载最新版本
http://nginx.org/en/linux_packages.html#stable
# 配置
./configure --prefix=/usr/local/nginx 
# 启动 Nginx
nginx -c /usr/local/nginx/conf/nginx.conf
注意：-c 指定配置文件的路径，不加的话，nginx会自动加载默认路径的配置文件，可以通过 -h查看帮助命令。
# 查看 Nginx 进程
ps -ef|grep nginx
```

#### Nginx常用命令(http://nginx.org/en/docs/beginners_guide.html)

```shell
# 启动 Nginx
nginx
# 停止 Nginx
nginx -s stop
nginx -s quit
# Nginx 重新加载配置
nginx -s reload
# 指定配置文件
nginx -c conf/nginx.conf
# 查看 Nginx 版本
nginx -v
nginx -V
# 检查配置文件是否正确
nginx -t
# 显示帮助信息
nginx -h
nginx -?
```

#### 安装文件上传模块

```shell
# 上传模块仓库
https://github.com/fdintino/nginx-upload-module
# ubuntu 解包：
https://coderwall.com/p/drhh8w/nginx-add-modules-and-repack-on-debian
# 安装重新打包deb
dpkg --install *.deb
```

#### 卸载 Nginx

```shell
# 列出本地与 ngnix 有关的软件包
dpkg --get-selections | grep nginx
# 卸载 nginx
apt-get remove --purge nginx
apt-get remove --purge nginx-core
apt-get remove --purge nginx-common
apt-get remove --purge nginx-doc
apt-get remove --purge nginx-full-dbg
```

