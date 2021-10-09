# Orange

## 版本介绍

> 系统版本：Ubuntu 16.04.7 LTS
> 
> OpenResty版本：1.19.3.2
>
> Lua版本：5.1.5
> 
> luarocks版本：3.7.0
> 
> Orange版本：0.8.1

## 安装

- 其他依赖

```shell
# install openresty and some compilation tools
sudo apt-get install -y curl git make libssl-dev \
    check libpcre3 libpcre3-dev libjemalloc-dev \
    libjemalloc1 build-essential libtool automake autoconf pkg-config cmake
```

- 安装`Lua`

```shell
curl -R -O http://www.lua.org/ftp/lua-5.1.5.tar.gz
tar zxf lua-5.1.5.tar.gz
cd lua-5.1.5
make linux test
make install
```

- 安装`OpenResty`

> 下载地址：http://openresty.org/cn/download.html

```shell
# 下载安装包
wget https://openresty.org/download/openresty-1.19.3.2.tar.gz

# 解压
tar -xzvf openresty-1.19.3.2.tar.gz

# 编译安装
cd openresty-VERSION
./configure --with-http_stub_status_module
make && make install

# 配置环境变量
echo 'export PATH=/usr/local/openresty/bin:$PATH' >> /etc/profile
source /etc/profile

```


- 安装`luarocks`

> 下载地址： https://luarocks.github.io/luarocks/releases/

```shell

# 下载安装包
wget https://luarocks.github.io/luarocks/releases/luarocks-3.7.0.tar.gz

# 解压
tar -zxvf luarocks-3.7.0.tar.gz

# 编译安装，make && make install 和 make bootstrap 之间选择，推荐 make bootstrap
make bootstrap

# 查看是否安装成功
luarocks --version
```

- 安装 `Lor Framework`

```shell
git clone https://github.com/sumory/lor.git
cd lor
sudo make install
```

- 下载`Orange`

```shell
git clone https://github.com/orlabs/orange.git
cd orange
sudo make dev
```

## 参考文档

> OpenResty安装：http://openresty.org/cn/installation.html
>
> Orange安装: http://orange.sumory.com/install/
>
> Luarocks安装： https://github.com/luarocks/luarocks/wiki/Download
>
> Lua安装： https://www.runoob.com/lua/lua-environment.html

## 项目介绍

## 常见问题

- `CentOS 8`中，`openssl`库中的一些库比较新，`luarocks`源上提供的`luacrypto`是一个旧版本，并不能很好使用`openssl`库文件

````shell
src/lcrypto.c: In function ‘digest_pnew’:
src/lcrypto.c:81:61: error: invalid application of ‘sizeof’ to incomplete type ‘EVP_MD_CTX {aka struct evp_md_ctx_st}’
     EVP_MD_CTX *c = (EVP_MD_CTX *)lua_newuserdata(L, sizeof(EVP_MD_CTX));
                                                             ^~~~~~~~~~
````

> 解决办法，修改 `rockspec/orange-master-0.rockspec`文件中依赖

```
dependencies = {
   ...
    "luacrypto = 0.3.2-2",
   ...
}
```

改为
```
dependencies = {
  ...
    "luacrypto2 = 0.3.2-1",
  ...
}
```