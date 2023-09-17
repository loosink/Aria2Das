#/bin/bash
sudo rm -rf ./install.sh
cd /

#Aria2密码
p=1234

#是否安装Apache2
a=y

#log,安装日志，保存于/root/log_of_install_aria2dash.log
log="/root/log_of_install_aria2dash.log"
date > $log

#默认网页路径
dir="/var/www/html"
d=$dir

if [ $d != $dir ] ; then
    dir=$d
    echo !
fi


while getopts ":p:a:d:h:" opt
do
    case $opt in
        p)
        p=$OPTARG
        ;;
        a)
        a=$OPTARG
        ;;
        d)
        d=$OPTARG
        ;;
        h)
        h=$OPTARG
        ;;
        ?)
        echo "WTF???"
        exit 
        ;;
    esac
done



#判断系统是debian，Ubuntu，Fedora，cent还是手机的turmux

if [[  $(command -v sudo apt)  ]] ; then
        cmd="sudo apt"
	echo "your system is Ubuntu/Debian" >>$log
	apache2="apache2"
    apt install sudo -y  #保证Debian能够使用sudo正常运行改脚本
    apt install wget -y  #下载wget
    apt install sudo -y  #保证sudo指令正常运行
else
        cmd="sudo yum"
	
	yum install epel-release -y
	yum install aria2 -y
 	yum install wget -y
	apache2="httpd"
        firewall-cmd --zone=public --add-port=80/tcp --permanent  #centos防火墙规则添加
	

fi


#安装必要的包
$cmd update 
#根据需要，安装Apache2
if [ $a = "y" ] ; then
    cmd1="$cmd install $apache2 -y"
    $cmd1
    sudo mv $dir/index.html $dir/index.html0
else  
    echo "I will not install apache2."
fi

#安装必要的
cmd2="$cmd install screen vim aria2 unzip git curl -y"
$cmd2

# 下载AriaNg

tmp="/tmp/Onekey-deploy_aria2"
sudo rm -rf $tmp
sudo git clone https://ghproxy.com/https://github.com/loosink/OneDriveUploader-Modify.git $tmp
sudo rm -rf $dir/lixian
sudo rm -rf $dir/downloads
sudo mkdir -p $dir/lixian 
sudo mkdir -p $dir/downloads
sudo unzip $tmp/*.zip -d $dir/lixian
sudo chmod 777 -R $dir/lixian
link="<a href="http://$ip:8080" target="blank">"
cat $dir/lixian/head.html > $dir/lixian/index.html
echo $link >> $dir/lixian/index.html
cat $dir/lixian/foot.html >> $dir/lixian/index.html
#sudo rm -rf $dir/index.html

#沃日，为啥一直bug。。。
ip=$(curl -s https://ipinfo.io/ip)
dir="/var/www/html"
link="<a href="http://$ip:8080" target="blank">"
sudo cat $dir/lixian/head.html > $dir/lixian/index.html
sudo echo $link >> $dir/lixian/index.html
sudo cat $dir/lixian/foot.html >> $dir/lixian/index.html
#安装FileBrowser
bash <(curl -s -L https://ghproxy.com/raw.githubusercontent.com/loosink/OneDriveUploader-Modify/main/Install/getFileBrowser.sh)




#开始配置aria2
sudo rm -rf /root/.aria2
sudo mkdir -p /root/.aria2
sudo rm -rf /root/.aria2/*
sudo touch /root/.aria2/aria2.session
sudo mv /tmp/Onekey-deploy_aria2/aria2.conf /root/.aria2/
sudo mv /tmp/Onekey-deploy_aria2/updatetracker.sh /root/.aria2/
sudo rm -rf ./install.sh
clear
secret="rpc-secret=$p"
upload="on-download-complete=/root/aria2upload.sh"
sudo echo $upload >> /root/.aria2/aria2.conf

#设置systemctl
sudo cp $tmp/aria2c /etc/init.d/
sudo cp $tmp/filebrowser /etc/init.d/
sudo chmod 777  /etc/init.d/aria2c
sudo chmod 777  /etc/init.d/filebrowser
sudo systemctl daemon-reload
sudo systemctl restart aria2c
sudo systemctl restart filebrowser

#如果使用httpd，注释掉欢迎文件内容，否则需要手动输入才能进入管理页面
if  [ $apache2 = "httpd" ] ; then
    sudo sed -i 's/^/#/' /etc/httpd/conf.d/welcome.conf
    echo "注释成功！"
    # 重启httpd服务
    sudo systemctl restart httpd
    echo "httpd服务已重启！"
else
    echo "没有使用httpd，不需要注释welcome.conf"
fi

#设置开机自启
sudo systemctl enable aria2c
sudo systemctl enable filebrowser
