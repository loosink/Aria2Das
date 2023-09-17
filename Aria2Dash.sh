#!/bin/bash
#get the latest Aria2Dash
#用来获取Aria2Dash的最新版本，如果是fork我脚本的，请自行更改tag_name和script_url的链接。
tag_name="$(curl -s https://api.github.com/repos/loosink/Aria2Das/releases/latest | grep -o '"tag_name": ".*"' | sed 's/"//g' | sed 's/tag_name: //g')"
script_url="https://ghproxy.com/https://github.com/loosink/Aria2Das/releases/download/$tag_name/install.sh"
echo "the latest script is $script_url"

echo "判断系统是debian，Ubuntu，Fedora，cent"

if [[  $(command -v sudo apt)  ]] ; then
        cmd="sudo apt"
	echo "your system is Ubuntu/Debian"
	apache2="apache2"
else
        cmd="sudo yum"
fi
$cmd install curl -y
curl -fsSL $script_url | bash
