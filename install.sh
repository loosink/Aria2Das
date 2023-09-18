echo "安装FileBrowser,如果国内服务器安装卡在这里，请ctrl + c 退出并参考高级安装，使用 -f n 跳过这一步安装。"
echo "程序主体已经安装完成。FileBrowser 如果下载太久可以不要。"
echo "在终端中直接输入aria2dash即可进入控制面板，有修改密码等功能"
echo "由于centos中filebrowser放行8080端口之后依旧无法使用，所以做了判定，如果系统为centos则不会安装filebrowser"
# if [ $f = "y" ]  ;  then
#     #bash $tmp/get-filebrowser.sh #因为最新版有无法编辑文件的bug，所以改了脚本，只装旧版
#     curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/loosink/Aria2Das/master/Install/getFileBrowser.sh | bash
#     sudo cp $tmp/filebrowser /etc/init.d/
#     sudo chmod 755  /etc/init.d/filebrowser
#     sudo systemctl daemon-reload
#     	if [[  $(command -v apt)  ]] ; then
#          sudo update-rc.d filebrowser defaults #Ubuntu用这个
# 	 sudo systemctl restart filebrowser
  
# 	else
# 	firewall-cmd --zone=public --add-port=8080/tcp --permanent
#         sudo chkconfig filebrowser on #Cent OS用这个
# 	sudo systemctl restart filebrowser
	
 
# 	fi
#     if [[  $(command -v filebrowser)  ]] ; then
# 	echo "installed filebrowser" >>$log
#     else
# 	echo "无法安装filebrowser，可能因为国内网络问题无法访问git导致">>$log
#     fi
   
    
# else
#     echo "not isntall FileBrowser">>$log
# fi

if [[ $f = "y" && $(command -v apt) ]]; then
    #bash $tmp/get-filebrowser.sh #因为最新版有无法编辑文件的bug，所以改了脚本，只装旧版
    curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/loosink/Aria2Das/master/Install/getFileBrowser.sh | bash
    sudo cp $tmp/filebrowser /etc/init.d/
    sudo chmod 755  /etc/init.d/filebrowser
    sudo systemctl daemon-reload
    sudo update-rc.d filebrowser defaults #Ubuntu用这个
	sudo systemctl restart filebrowser


    if [[  $(command -v filebrowser)  ]] ; then
	    echo "installed filebrowser" >>$log
    else
	    echo "无法安装filebrowser，可能因为国内网络问题无法访问git导致">>$log
    fi
   
    
else
    echo "not isntall FileBrowser">>$log
fi
