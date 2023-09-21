# OneDriveUploader-Modify

## 特别感谢

该项目整合自[Aria2Dash](https://github.com/Masterchiefm/Aria2Dash)以及[OneList](https://github.com/MoeClub/OneList)

# 目前已经测试过可以使用的系统（含版本）


ubuntu-22.04.3-live-server-amd64

CentOS-7-x86_64-Minimal-2009 B站使用的版本

CentOS-7-x86_64-DVD-2009

CentOS-8.5.2111-x86_64-dvd1.iso

# 测试的其他系统

debian-12.1.0-amd64-DVD-1  重启后不会保存进程，并且重启后丢失tracker

Centos6目前还在测试。存在的问题有   1.重启之后需要手动执行`/etc/init.d/aria2c start`，不知道什么原因无法进行开机自启   2.不支持https

# 脚本运行前操作

使用SSH需要先将 `/etc/ssh/sshd_config` 中 `#PermitRootLogin `行 改为 `PermitRootLogin yes`
并删除`#Port 22`前的注释符号

![image](https://github.com/loosink/Aria2Das/assets/30341914/b11e47a1-73d1-4526-b31c-c8f9dcec8329)


修改后保存，使用`systemctl restart sshd`对ssh服务重启后就可以使用ssh工具远程连接


# 一键安装

## 配置Github加速（国内用户）
```
sh -c 'sed -i "/# GitHub520 Host Start/Q" /etc/hosts && curl https://raw.hellogithub.com/hosts >> /etc/hosts'
```


使用前需要先安装curl wget，安装后即可使用  安装需要使用root用户，因为用sudo不同系统会出不同bug，以后再修
```
apt install wget curl whiptail dialog -y
```
```
yum install wget curl -y
```
安装aria2服务

```
bash <(curl -s -L https://raw.githubusercontent.com/loosink/Aria2Das/master/Aria2Dash.sh)
```

安装OneDrive Uploader（可选）

```
bash <(curl -s -L https://raw.githubusercontent.com/loosink/Aria2Das/master/Install/getOneDriveUploader.sh)
```



# 授权方法以及使用说明、初始化配置文件（可选）
[参考wiki](https://github.com/loosink/Aria2Das/blob/master/Install/wiki.md)


# 安装自动上传脚本（可选）

```
wget https://raw.githubusercontent.com/loosink/Aria2Das/master/Install/aria2upload.sh -P /root/ && chmod 777 /root/aria2upload.sh && chmod +x /root/aria2upload.sh
```

# FileBrowser
运行在8080端口，默认账号密码均为admin，初次上线到settings-profile settings里更改密码


