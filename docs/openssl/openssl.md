目前最流行的 SSL 密码库工具

```shell
# ubuntu 16.04 更新 openssl
cd /usr/local/src
wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_1a.zip
unzip OpenSSL_1_1_1a.zip
cd openssl-OpenSSL_1_1_1a/
./config --prefix=/usr/local/openssl-1_1_1a
make && make install
mv /usr/bin/openssl /usr/bin/openssl.old
mv /usr/include/openssl /usr/include/openssl.old

ln -s /usr/local/openssl-1_1_1a/bin/openssl /usr/bin/openssl
ln -s /usr/local/openssl-1_1_1a/include/openssl/ /usr/include/openssl

# 更新动态链接库数据

echo /usr/local/openssl-1_1_1a/lib/ > /etc/ld.so.conf
openssl version

ln -s /usr/local/lib/libssl.so.1.1 /usr/lib/libssl.so.1.1  
ln -s /usr/local/lib/libcrypto.so.1.1 /usr/lib/libcrypto.so.1.1 
```