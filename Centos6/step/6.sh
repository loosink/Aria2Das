#!/bin/bash
#编译安装autoconf
cp ./Aria2Das/Centos6/gcc/autoconf-2.71.zip ./
#wget https://ghproxy.com/https://github.com/loosink/Aria2Das/blob/master/Centos6/gcc/autoconf-2.71.zip
unzip autoconf-2.71.zip
cd autoconf-2.71
yum install perl* -y
chmod +x *
./configure
make
make install
rm -rf /usr/bin/autoreconf
rm -rf /usr/bin/autoconf
autoreconf -V
cd
rm -rf autoconf*
echo "6.sh运行完毕"