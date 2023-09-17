# OneDriveUploader-Modify

# 脚本运行前操作

## debian-12.1.0

使用SSH需要先将 `/etc/ssh/sshd_config` 中 `#PermitRootLogin prohibit-password` 改为 `PermitRootLogin yes`

修改前

![image](https://github.com/loosink/OneDriveUploader-Modify/assets/30341914/65270676-8c27-4c29-91cb-dec5dfb78d19)


修改后
![image](https://github.com/loosink/OneDriveUploader-Modify/assets/30341914/68b7afb4-1d49-4e52-aeb9-02124efbcbe9)

![image](https://github.com/loosink/OneDriveUploader-Modify/assets/30341914/7a7d2fa4-7218-4b85-a9b7-3758d6a8fdd8)
sudo systemctl restart ssh


修改后保存，使用`systemctl restart ssh`对ssh服务重启后就可以使用ssh工具远程连接

运行脚本前检查 `/etc/apt/sources.list` 中 `cdrom`行是否已经被注释，如果没有被注释掉需要进行注释，否则软件安装过程可能会出错

如图，cdrom行需要被注释掉，否则更新报错
![image](https://github.com/loosink/OneDriveUploader-Modify/assets/30341914/d743aa71-04e1-4038-9bab-34ec0f2315fd)


## CentOS-7-x86_64-Minimal-2009

使用SSH需要先将 `/etc/ssh/sshd_config` 中 `#PermitRootLogin yes` 前的注释删除掉

![image](https://github.com/loosink/OneDriveUploader-Modify/assets/30341914/e6b97b00-e374-440e-89a2-8a501c01cd77)


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
bash <(curl -s -L https://ghproxy.com/https://raw.githubusercontent.com/loosink/OneDriveUploader-Modify/main/Install/getOneDriveUploader.sh)
```



# 授权方法以及使用说明、初始化配置文件
[参考wiki](https://github.com/loosink/OneDriveUploader-Modify/blob/main/Install/wiki.md)


# 安装自动上传脚本（可选）

```
wget https://ghproxy.com/https://raw.githubusercontent.com/loosink/OneDriveUploader-Modify/main/Install/aria2upload.sh -P /root/ && chmod 777 /root/aria2upload.sh && chmod +x /root/aria2upload.sh
```

# FileBrowser
运行在8080端口，默认账号密码均为admin，初次上线到settings-profile settings里更改密码

# ~~自动更新tracker~~（弃坑，手动更新吧）
~~首次使用crontab需要先`crontab -e`生成对应文件，粘贴下列代码后保存~~

~~设置每两个小时执行一次tracker更新~~

~~重启后自动更新一次tracker~~

~~0 */2 * * * /bin/sh /root/.aria2/updatetracker.sh~~

~~@reboot /root/.aria2/updatetracker.sh~~

