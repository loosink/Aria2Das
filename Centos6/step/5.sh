#!/bin/bash
#编译安装gettext
curl -O https://gh.api.99988866.xyz/https://github.com/loosink/Aria2Das/releases/download/2.2.2/gettext.zip
unzip gettext.zip
cd gettext-0.21
chmod +x *
./configure
make
make install
rm -rf /bin/gettext /usr/bin/gettext /usr/bin/gettext.sh /usr/lib64/gettext
gettext -V
cd
rm -rf gettext*
echo "5.sh运行完毕"
