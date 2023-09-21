#!/bin/bash

#定义yum安装命令
yum install -y wget curl unzip
yum install -y gcc
yum install -y glibc-devel.i686
yum install -y glibc-devel
yum install -y gcc-c++
yum install -y git
yum install dos2unix -y

#git clone https://ghproxy.com/https://github.com/loosink/Aria2Das.git
echo "1.sh运行完毕"
