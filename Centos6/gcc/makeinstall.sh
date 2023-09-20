#!/bin/bash
cd   #保证和1~10脚本中工作路径一致，防止出现各种bug
# 设置URL和脚本文件夹路径

# 检查aria2c命令是否可执行
if command -v aria2c &> /dev/null; then
    echo "aria2c命令可执行，跳过编译安装"
    exit 0
else
    echo "开始编译安装gcc以及aria2c"
    git clone https://ghproxy.com/https://github.com/loosink/Aria2Das.git

    for i in {1..10}; do
        bash "./Aria2Das/Centos6/step/${i}.sh"
        rm "./Aria2Das/Centos6/step/${i}.sh"
    done
fi
