#!/bin/bash
cd   #保证和1~10脚本中工作路径一致，防止出现各种bug
# 设置URL和脚本文件夹路径

# 检查aria2c命令是否可执行
if command -v aria2c &> /dev/null; then
    echo "aria2c命令可执行，跳过编译安装"
    exit 0
else
    echo "开始编译安装gcc以及aria2c"
    rm -rf /root/Aria2Das/
    git clone https://gitee.com/loosink/Aria2Das.git
    
    addr=./Aria2Das/Centos6/step
    chmod +x $addr/*
    bash $addr/1.sh
    bash $addr/2.sh
    bash $addr/3.sh
    bash $addr/4.sh
    bash $addr/5.sh
    bash $addr/6.sh
    bash $addr/7.sh
    bash $addr/8.sh
    bash $addr/9.sh
    bash $addr/10.sh

fi
