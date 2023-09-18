dir=$(cat wwwdir)
echo "下载AriaNg"
tmp="/tmp/Aria2Dash"
rm -rf $tmp
rm -rf $dir/ariang
rm -rf $dir/downloads

git clone https://github.com/Masterchiefm/Aria2Dash.git $tmp
mkdir -p $dir/ariang 
mkdir -p $dir/downloads
unzip $tmp/*.zip -d $dir/ariang
chmod 777 -R $dir/ariang

echo "正在获取服务器ip，然后填入AriaNg"
ip=$(curl -s https://ipapi.co/ip)
echo "你的公网ip是$ip"
link="<a href="http://$ip:8080" target="blank">"
cat $dir/ariang/head.html > $dir/ariang/index.html
echo $link >> $dir/ariang/index.html
cat $dir/ariang/foot.html >> $dir/ariang/index.html
echo "$link filebrowser" > $dir/filebrowser.html
echo "</a>" >> $dir/filebrowser.html
echo "完成"
