#!/bin/bash
#编译安装aria2c
cd
yum install automake m4 libtool -y
cp ./Aria2Das/Centos6/gcc/aria2-1.32.0.zip ./
unzip aria2-1.32.0.zip
cd aria2-1.32.0

# 检查bashrc文件中是否已经存在该路径
if grep -Fxq "/usr/local/mpc/lib/" ~/.bashrc; then
    echo "路径已存在于bashrc文件中"
else
    # 将路径添加到bashrc文件末尾
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/mpc/lib/" >>~/.bashrc
    echo "路径已成功添加到bashrc文件中"

    # 使bashrc文件生效
    source ~/.bashrc
    echo "bashrc文件已生效"
fi

chmod +x *
autoreconf -i
./configure
make
make install
aria2c --version
cd
rm -rf aria2-1.32.0*
echo "9.sh运行完毕"
