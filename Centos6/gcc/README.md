GCC编译所需文件
```
yum install wget curl unzip libtool glibc-devel.i686 libstdc++-devel.i686 gcc gcc-c++ -y
```


#安装依赖包
```
wget https://ghproxy.com/https://github.com/loosink/Aria2Das/blob/master/Centos6/gcc/mpfr-2.4.2.tar.bz2
wget https://ghproxy.com/https://github.com/loosink/Aria2Das/blob/master/Centos6/gcc/gmp-4.3.2.tar.bz2
wget https://ghproxy.com/https://github.com/loosink/Aria2Das/blob/master/Centos6/gcc/mpc-0.8.1.tar.gz
tar -jxf mpfr-2.4.2.tar.bz2
tar -jxf gmp-4.3.2.tar.bz2
tar -zxvf mpc-0.8.1.tar.gz
```
#编译安装gmp
```
cd gmp-4.3.2
chmod +x *
./configure --prefix=/usr/local/gmp
make &&make install
cd ..
rm -rf gmp*
```
#编译安装mpfr
```
cd mpfr-2.4.2
chmod +x *
./configure --prefix=/usr/local/mpfr -with-gmp=/usr/local/gmp
make &&make install
cd ..
rm -rf mpfr*
```
#编译安装mpc
```
cd mpc-0.8.1
chmod +x *
./configure --prefix=/usr/local/mpc -with-mpfr=/usr/local/mpfr -with-gmp=/usr/local/gmp
make &&make install
cd ..
rm -rf mpc*
```

```
#!/bin/bash
# install gcc 4.8.5
wget http://192.168.1.244:8080/gcc-4.8.5.tar.bz2
tar -jxf gcc-4.8.5.tar.bz2
cd gcc-4.8.5
chmod +x *
./contrib/download_prerequisites
mkdir gcc-build-4.8.5
cd gcc-build-4.8.5
../configure -enable-checking=release -enable-languages=c,c++ -disable-multilib
yum install -y glibc-devel.i686 glibc-devel
make
make install
cd /root
rm -rf gcc*

#备份旧版gcc
#mv /usr/bin/gcc /usr/bin/gcc-4.4.7
#mv /usr/bin/g++ /usr/bin/g++-4.4.7
#echo 'export PATH=$PATH:/usr/local/gcc-4.8.5/bin/' | sudo tee -a /etc/profile
```


```
cd /root
wget http://192.168.1.244:8080/gettext-0.21.zip
unzip gettext-0.21.zip
cd gettext-0.21
chmod +x *
./configure
make
make install
rm -rf /bin/gettext /usr/bin/gettext /usr/bin/gettext.sh /usr/lib64/gettext
gettext -V
cd /root
rm -rf gettext*
```

```
wget http://192.168.1.244:8080/autoconf-2.71.zip
unzip autoconf-2.71.zip
cd autoconf-2.71
chmod +x *
./configure
make
make install
rm -rf /usr/bin/autoreconf
rm -rf /usr/bin/autoconf
autoreconf -V
cd /root
rm -rf autoconf*
```


```
wget http://192.168.1.244:8080/aria2-1.32.0.zip
unzip aria2-1.32.0.zip
cd aria2-1.32.0
chmod +x *
autoreconf -i
./configure
make
make install
aria2c --version
cd /root
rm -rf aria2-1.32.0*
```
