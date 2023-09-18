# OneDriveUploader-Modify

## 特别感谢

该项目整合自[Aria2Dash](https://github.com/Masterchiefm/Aria2Dash)以及[OneList](https://github.com/MoeClub/OneList)

# 目前已经测试过可以使用的系统（含版本）

debian-12.1.0-amd64-DVD-1

ubuntu-22.04.3-live-server-amd64

CentOS-7-x86_64-Minimal-2009 B站使用的版本

CentOS-7-x86_64-DVD-2009


# 脚本运行前操作

使用SSH需要先将 `/etc/ssh/sshd_config` 中 `#PermitRootLogin `行 改为 `PermitRootLogin yes`
并删除`#Port 22`前的注释符号

![image](https://github.com/loosink/Aria2Das/assets/30341914/b11e47a1-73d1-4526-b31c-c8f9dcec8329)


修改后保存，使用`systemctl restart sshd`对ssh服务重启后就可以使用ssh工具远程连接

**Debian**运行脚本前检查 `/etc/apt/sources.list` 中 `cdrom`行是否已经被注释，如果没有被注释掉需要进行注释，否则软件安装过程可能会出错

如图，cdrom行需要被注释掉，否则更新报错

![image](https://github.com/loosink/Aria2Das/assets/30341914/0ecf395a-b74c-4e21-8439-6e12a7a39059)



# 一键安装

使用前需要先安装curl wget，安装后即可使用
```
apt install wget curl whiptail dialog -y
```
```
yum install wget curl -y
```
安装aria2服务

```
bash <(curl -s -L https://ghproxy.com/https://raw.githubusercontent.com/loosink/Aria2Das/master/Aria2Dash.sh)
```

安装OneDrive Uploader（可选）

```
bash <(curl -s -L https://ghproxy.com/https://raw.githubusercontent.com/loosink/Aria2Das/master/Install/getOneDriveUploader.sh)
```



# 授权方法以及使用说明、初始化配置文件
[参考wiki](https://github.com/loosink/Aria2Das/blob/master/Install/wiki.md)


# 安装自动上传脚本（可选）

```
wget https://ghproxy.com/https://raw.githubusercontent.com/loosink/Aria2Das/master/Install/aria2upload.sh -P /root/ && chmod 777 /root/aria2upload.sh && chmod +x /root/aria2upload.sh
```

# FileBrowser
运行在8080端口，默认账号密码均为admin，初次上线到settings-profile settings里更改密码


