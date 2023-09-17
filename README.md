# OneDriveUploader-Modify

## 特别感谢

该项目整合自[Aria2Dash](https://github.com/Masterchiefm/Aria2Dash)以及[OneList](https://github.com/MoeClub/OneList)

# 脚本运行前操作

## debian-12.1.0

使用SSH需要先将 `/etc/ssh/sshd_config` 中 `#PermitRootLogin prohibit-password` 改为 `PermitRootLogin yes`

修改前

![image](https://github.com/loosink/Aria2Das/assets/30341914/5085c7a1-2227-4159-b69d-69062ca8ea75)



修改后

![image](https://github.com/loosink/Aria2Das/assets/30341914/5ce80467-b715-4e17-838c-84406f9eac25)

修改后保存，使用`systemctl restart ssh`对ssh服务重启后就可以使用ssh工具远程连接

## ubuntu-22.04.3-live-server-amd64

修改成如图

![image](https://github.com/loosink/Aria2Das/assets/30341914/7c68d48d-f445-4c72-8181-99ab4475e101)

修改后保存，使用`systemctl restart ssh`对ssh服务重启后就可以使用ssh工具远程连接

运行脚本前检查 `/etc/apt/sources.list` 中 `cdrom`行是否已经被注释，如果没有被注释掉需要进行注释，否则软件安装过程可能会出错

如图，cdrom行需要被注释掉，否则更新报错

![image](https://github.com/loosink/Aria2Das/assets/30341914/0ecf395a-b74c-4e21-8439-6e12a7a39059)



## CentOS-7-x86_64-Minimal-2009

使用SSH需要先将 `/etc/ssh/sshd_config` 中 `#PermitRootLogin yes` 前的注释删除掉

![image](https://github.com/loosink/Aria2Das/assets/30341914/f9ad690c-77eb-4020-833b-99f493656a0e)



修改后保存，使用`systemctl restart sshd`对ssh服务重启后就可以使用ssh工具远程连接



# 一键安装

使用前需要先安装curl wget，安装后即可使用
```
apt install wget curl sudo -y
```
```
yum install wget curl -y
```
安装aria2服务

```
bash <(curl -s -L https://ghproxy.com/https://raw.githubusercontent.com/loosink/Aria2Das/master/Aria2Dash.sh)

```

安装OneDrive Uploader

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


