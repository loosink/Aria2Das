#!/bin/bash
#编译安装mpfr
cd
cp ./Aria2Das/Centos6/gcc/mpfr-2.4.2.tar.bz2 ./
tar -jxf mpfr-2.4.2.tar.bz2
cd mpfr-2.4.2
chmod +x *
./configure --prefix=/usr/local/mpfr -with-gmp=/usr/local/gmp
make
make install
cd
rm -rf mpfr-2.4.2*
echo "3.sh运行完毕"