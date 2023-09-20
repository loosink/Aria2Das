#!/bin/bash
#编译安装gmp
yum remove -y gcc
yum install -y gcc
cd
cp ./Aria2Das/Centos6/gcc/gmp-4.3.2.tar.bz2 ./
#wget https://ghproxy.com/https://github.com/loosink/Aria2Das/blob/master/Centos6/gcc/gmp-4.3.2.tar.bz2
tar -jxf gmp-4.3.2.tar.bz2
cd gmp-4.3.2
chmod +x *
./configure --prefix=/usr/local/gmp
make
make install
cd
rm -rf gmp-4.3.2*
echo "2.sh运行完毕"