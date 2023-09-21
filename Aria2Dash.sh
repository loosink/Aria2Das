#!/bin/bash
#get the latest Aria2Dash
#用来获取Aria2Dash的最新版本，如果是fork我脚本的，请自行更改tag_name和script_url的链接。
tag_name="$(curl -s https://api.github.com/repos/loosink/Aria2Das/releases/latest | grep -o '"tag_name": ".*"' | sed 's/"//g' | sed 's/tag_name: //g')"
script_url="https://github.com/loosink/Aria2Das/releases/download/$tag_name/install.sh"
echo "the latest script is $script_url"

echo "判断系统是debian，Ubuntu，Fedora，cent"

if command -v apt >/dev/null 2>&1; then
        cmd="apt"
	echo "your system is Ubuntu/Debian"
	apache2="apache2"
elif command -v yum >/dev/null 2>&1; then
        cmd="yum"
else
    # 如果系统中没有yum或apt命令
    echo "无法识别Linux包管理器"
    exit 1
fi

echo "使用$cmd进行curl的安装"

$cmd install curl -y
curl -fsSL $script_url | bash
