#!/bin/bash
#创建软链接
mv /usr/bin/c++ /usr/bin/c++.bak
ln -s /usr/local/gcc/bin/c++ /usr/bin/c++
mv /usr/bin/g++ /usr/bin/g++.bak
ln -s /usr/local/gcc/bin/g++ /usr/bin/g++
mv /usr/bin/gcc /usr/bin/gcc.bak
ln -s /usr/local/gcc/bin/gcc /usr/bin/gcc

echo "8.sh运行完毕"