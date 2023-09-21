#/bin/bash

rm -rf ./Aria2Dash.sh
cd /

#预设变量
#Aria2密码
p=1234

#是否安装Apache2
a=y

#默认网页路径
dir="/var/www/html"
d=$dir #预先给d赋值，免得下面要是不输入东西的话判断报错

#filebrowser,因为GFW，国内VPS可能装不上,默认是可以装
f=y

#log,安装日志，保存于/root/log_of_install_aria2dash.log
log="/root/log_of_install_aria2dash.log"
date >$log

aria2c="aria2c"

firewall="firewalld.service" #centos6不用这个

systemctl="systemctl"
reloadsystemd="systemctl daemon-reload"
firewallcmd="firewall-cmd --zone=public --add-port=6800/tcp --permanent" #默认是这个，防火墙开通aria2c所用的6800端口
firewall80="firewall-cmd --zone=public --add-port=80/tcp --permanent"    #防火墙设置,开通httpd服务所需80端口,默认是这个

aria2crestart="$systemctl restart $aria2c" #默认是这个
httpd="httpd"
httpdrestart="$systemctl restart $httpd" #默认是这个重启apache2

enablearia2c="$systemctl enable $aria2c" #默认用这个自启aria2c

while getopts ":p:a:d:f:h:" opt; do
    case $opt in
    #aria2自定密码
    p)
        p=$OPTARG
        ;;
    #是否安装apache/httpd
    a)
        a=$OPTARG
        ;;
    #指定网页根目录
    d)
        d=$OPTARG
        ;;
    #是否安装filebrowser，国内建议不装
    f)
        f=$OPTARG
        ;;
    #帮助，暂时不搞
    h)
        h=$OPTARG
        ;;
    ?)
        echo "WTF???"
        exit
        ;;
    esac
done

#把进程修改为变量，便于centos6和7重启相应的进程
aria2c="aria2c"
filebrowser="filebrowser"

#若用户输入网页根目录与预设不一致，则将dir变量值改为用户设置的
if [ $d != $dir ]; then
    echo "d!=dir"
    dir=$d

fi
echo "ariang directory is $dir" >>$log

echo "判断系统是Ubuntu，cent"

if command -v yum >/dev/null 2>&1; then
    # 如果系统中有yum命令
    cmd="yum"
    $cmd -y install epel-release
    apache2="httpd"
elif command -v apt >/dev/null 2>&1; then
    # 如果系统中有apt命令
    cmd="apt"
    echo "your system is Ubuntu/Debian"
    apache2="apache2"

else
    # 如果系统中没有yum或apt命令
    echo "无法识别Linux包管理器"
    exit 1
fi
echo "cmd: $cmd"

restartapache="$systemctl restart $apache2"

enableapache="$systemctl enable $apache2" #默认用这个自启Apache

install="auto" #这个变量是留给Centos6的，如果是6则该值为manual，执行makeinstall手动编译

restartfirewall="$systemctl restart $firewall"
# 检查是否为CentOS 6
if [[ -f /etc/redhat-release ]]; then
    if grep -q "CentOS release 6" /etc/redhat-release; then
        echo "当前系统为CentOS 6"
        systemctl="service"
        reloadsystemd="chkconfig daemon-reload"
        restartapache="$systemctl $apache2 restart"
        firewall="iptables"                                                                      #centos6用这个
        firewallcmd="$firewall -I INPUT -p tcp --dport 6800 -j ACCEPT && service $firewall save" #Centos6就喜欢搞特殊,这句话开6800端口
        firewall80="$firewall -I INPUT -p tcp --dport 80 -j ACCEPT && service $firewall save"    #Centos6开80端口

        aria2crestart="$systemctl $aria2c restart" #Centos6用这个重启aria2c
        httpdrestart="$systemctl $httpd restart"   #Centos6重启httpd

        enablearia2c="chkconfig aria2c on" #centos6用这个自启aria2c
        enableapache="chkconfig httpd on"  #centos6用这个自启Apache

        install="manual" #使用编译安装
        restartfirewall="$systemctl $firewall save && $systemctl $firewall restart"
    fi
fi

# 检查是否为CentOS 7
if [[ $cmd="yum" && -f /etc/redhat-release ]]; then
    if grep -q "CentOS Linux release 7" /etc/redhat-release; then
        echo "当前系统是CentOS 7"

    fi
fi

# 检查是否为CentOS 8
if [[ $cmd="yum" && -f /etc/os-release ]]; then
    if grep -q "CentOS Linux release 8" /etc/os-release; then
        echo "当前系统是CentOS 8"
        #Centos8需要更改repo才可以下载httpd
        mkdir /etc/yum.repos.d/backup
        mv *repo /etc/yum.repos.d/bakup/
        wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo
        yum makecache
    fi
fi

###############################安装必须的包#################################
echo "Updatting..."
$cmd update -y
$cmd install unzip -y
echo "根据需要，安装Apache2或者httpd"
if [ $a = "y" ]; then
    echo "安装$apache2"
    cmd1="$cmd install $apache2 -y"
    $cmd1
    mv $dir/index.html $dir/index.html0
    $restartapache
else
    echo "you choosed not to install apache2/httpd."

fi

touch $dir/Aria2Dash_is_installing
#其实screen，vim可以不用。。但是我为了自己方便就加上了
cmd2="$cmd install screen vim  unzip git curl -y"
$cmd2
#以防万一，每个包单独安装
cmd3="$cmd install vim  -y"
$cmd3

cmd3="$cmd install unzip  -y"
$cmd3
if [[ $(command -v unzip) ]]; then
    echo "installed unzip" >>$log
else
    echo "install unzip failed" >>$log
fi

cmd3="$cmd install git  -y"
$cmd3
if [[ $(command -v git) ]]; then
    echo "installed git" >>$log
else
    echo "install git failed" >>$log
fi

cmd3="$cmd install curl  -y"
$cmd3
if [[ $(command -v curl) ]]; then
    echo "installed curl" >>$log
else
    echo "install curl failed" >>$log
fi

if [ "$install" = "auto" ]; then
    echo "installed aria2 auto"
else
    echo "是Centos6系统，采用编译安装的方式"
    echo "时间会很长，安装过程可以去做一些别的事情"
    curl -fsSL https://raw.githubusercontent.com/loosink/Aria2Das/master/Centos6/gcc/makeinstall.sh | bash
fi

if [[ $(command -v aria2c) ]]; then
    echo "installed aria2" >>$log
else
    echo "install aria2 failed" >>$log
fi
###############################安装必须的包####################################

###############################配置网页管理端AriaNG#############################
echo "下载AriaNg"
tmp="/tmp/Aria2Dash"
rm -rf $tmp
rm -rf $dir/ariang
rm -rf $dir/downloads

git clone https://github.com/loosink/Aria2Das.git $tmp
mkdir -p $dir/ariang
mkdir -p $dir/downloads
unzip $tmp/*.zip -d $dir/ariang
chmod 777 -R $dir/ariang

echo "正在获取服务器ip，然后填入AriaNg"
ip=$(curl -s https://ipapi.co/ip)
echo "你的公网ip是$ip"
link="<a href="http://$ip:8080" target="blank">"
cat $dir/ariang/head.html >$dir/ariang/index.html
echo $link >>$dir/ariang/index.html
cat $dir/ariang/foot.html >>$dir/ariang/index.html
echo "$link filebrowser" >>$dir/filebrowser.html
echo "</a>" >>$dir/filebrowser.html
###############################配置网页管理端AriaNG#############################

###############################aria2配置文件修改#####################################
echo "开始配置aria2"
rm -rf /root/.aria2
mkdir -p /root/.aria2
touch /root/.aria2/aria2.session
mv /tmp/Aria2Dash/aria2.conf /root/.aria2/
mv /tmp/Aria2Dash/updatetracker.sh /root/.aria2/
rm -rf ./install.sh

secret="rpc-secret=$p"

upload="on-download-complete=/root/aria2upload.sh"
echo $upload >>/root/.aria2/aria2.conf

if [ "$install" = "auto" ]; then
    #echo $secret >> /root/.aria2/aria2.conf
    echo "设置systemctl"
    cp $tmp/aria2c /etc/init.d/
    chmod 755 /etc/init.d/aria2c
    $reloadsystemd
else #Centos6的配置
    echo "设置systemctl,是Centos6系统"
    cp $tmp/aria2c /etc/init.d/
    chmod +x /etc/init.d/aria2c
    # 检测crontab中是否存在指定命令
    check_crontab() {
        crontab -l | grep -q "$1"
        return $?
    }

    # 添加指定命令到crontab
    add_to_crontab() {
        (
            crontab -l 2>/dev/null
            echo "$1"
        ) | crontab -
    }

    # 检测并添加指定命令到crontab
    check_and_add_command() {
        check_crontab "$1"
        if [ $? -ne 0 ]; then
            add_to_crontab "$1"
            echo "已成功添加命令到crontab。"
        else
            echo "crontab中已存在指定命令。"
        fi
    }

    # 检测并添加第一个命令
    check_and_add_command "@reboot /bin/bash /root/.aria2/updatetracker.sh"

    # 检测并添加第二个命令
    check_and_add_command "@reboot /usr/local/bin/aria2c --conf-path=/root/.aria2/aria2.conf -D"

    $systemctl crond restart

fi

if [[ $(command -v apt) ]]; then
    update-rc.d aria2c defaults #Ubuntu用这个
    echo "Ubuntu/Debian"
else
    chkconfig aria2c on #Cent OS用这个
    echo "Cent OS"
    $firewallcmd #防火墙开通aria2c所用的6800端口,Centos需要这一步
    $firewall80  #防火墙开通httpd所用的80端口,Centos需要这一步
    $restartfirewall
fi

$aria2crestart

###############################安装filebrowser#####################################

if command -v apt >/dev/null 2>&1; then
    echo "安装FileBrowser,如果国内服务器安装卡在这里，请ctrl + c 退出并参考高级安装，使用 -f n 跳过这一步安装。"
    echo "程序主体已经安装完成。FileBrowser 如果下载太久可以不要。"
    echo "在终端中直接输入aria2dash即可进入控制面板，有修改密码等功能"
    echo "由于centos中filebrowser放行8080端口之后依旧无法使用，所以做了判定，如果系统为centos则不会安装filebrowser"

    #bash $tmp/get-filebrowser.sh #因为最新版有无法编辑文件的bug，所以改了脚本，只装旧版
    curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/loosink/Aria2Das/master/Install/getFileBrowser.sh | bash
    cp $tmp/filebrowser /etc/init.d/
    chmod 755 /etc/init.d/filebrowser
    $reloadsystemd
    update-rc.d filebrowser defaults #Ubuntu用这个
    systemctl restart filebrowser

elif command -v yum >/dev/null 2>&1; then
    echo "你的系统使用的是yum，所以无法安装filebrowser"
else
    echo "not isntall FileBrowser" >>$log
fi

if [[ $(command -v filebrowser) ]]; then
    echo "installed filebrowser" >>$log
    cp $tmp/filebrowser /etc/init.d/
else
    echo "无法安装filebrowser，可能因为国内网络问题无法访问git导致" >>$log
fi

###############################安装filebrowser#####################################

#设置systemctl
cp $tmp/aria2c /etc/init.d/
chmod 755 /etc/init.d/aria2c
$reloadsystemd

#如果使用httpd，注释掉欢迎文件内容，否则需要手动输入才能进入管理页面
if [ $apache2 = "httpd" ]; then
    sed -i 's/^/#/' /etc/httpd/conf.d/welcome.conf
    echo "注释成功！"
    # 重启httpd服务
    $httpdrestart

    echo "httpd服务已重启！"
else
    echo "没有使用httpd，不需要注释welcome.conf"
fi

$enablearia2c
$enableapache

###############################aria2配置文件修改#####################################

if which yum >/dev/null 2>&1; then
    if [[ $(cat /etc/centos-release) == *"CentOS release 6"* ]]; then
        echo "CentOS 6不支持安装控制面板，因为没有Python 3"
        echo "同时由于Centos6兼容问题（作者太菜）"
        echo "aria2c开机设为自动启动，暂停需要先用which aria2c查找一下"
        echo "然后引用绝对路径进行操作"
        echo "如果没有什么特殊需求就不需要管他"
    fi
else
    ###############################控制面版#############################
    rm -rf /etc/aria2dash
    mkdir /etc/aria2dash
    mv $tmp/aria2dash.py /etc/aria2dash
    mv $tmp/changewwwdir.sh /etc/aria2dash
    echo $dir >/etc/aria2dash/wwwdir
    touch /usr/bin/aria2dash
    echo "python3 /etc/aria2dash/aria2dash.py" >/usr/bin/aria2dash
    chmod 777 /usr/bin/aria2dash
    source ~/.bashrc
    ###############################控制面版#############################

    rm $dir/Aria2Dash_is_installing
    echo "==============================================================="
    cat $log
    echo "==============================================================="
    echo "Commands:"
    echo "在终端中直接输入aria2dash即可进入控制面板，有修改密码等功能"
    echo "可以用systemctl stop aria2c 等方式单个关闭aria2或者filebrowser"

fi
