#!/bin/bash
#编译安装mpc
cp ./Aria2Das/Centos6/gcc/mpc-0.8.1.tar.gz ./
tar -zxvf mpc-0.8.1.tar.gz
cd mpc-0.8.1
chmod +x *
./configure --prefix=/usr/local/mpc -with-mpfr=/usr/local/mpfr -with-gmp=/usr/local/gmp
make
make install
cd 
rm -rf mpc-0.8.1*
echo "4.sh运行完毕"