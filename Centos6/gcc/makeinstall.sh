#!/bin/bash
# install aria2c
#yum install wget curl unzip libtool glibc-devel.i686 libstdc++-devel.i686 gcc gcc-c++ -y
#yum groupinstall "Development Tools" -y
yum install wget curl unzip gcc glibc-devel.i686 glibc-devel gcc-c++ -y

#编译安装gmp
cd /root
wget https://ghproxy.com/https://github.com/loosink/Aria2Das/blob/master/Centos6/gcc/gmp-4.3.2.tar.bz2
tar -jxf gmp-4.3.2.tar.bz2
cd gmp-4.3.2
chmod +x *
./configure --prefix=/usr/local/gmp
make && make install
cd ..
rm -rf gmp*
#编译安装mpfr
wget https://ghproxy.com/https://github.com/loosink/Aria2Das/blob/master/Centos6/gcc/mpfr-2.4.2.tar.bz2
tar -jxf mpfr-2.4.2.tar.bz2
cd mpfr-2.4.2
chmod +x *
./configure --prefix=/usr/local/mpfr -with-gmp=/usr/local/gmp
make && make install
cd ..
rm -rf mpfr*
#编译安装mpc
wget https://ghproxy.com/https://github.com/loosink/Aria2Das/blob/master/Centos6/gcc/mpc-0.8.1.tar.gz
tar -zxvf mpc-0.8.1.tar.gz
cd mpc-0.8.1
chmod +x *
./configure --prefix=/usr/local/mpc -with-mpfr=/usr/local/mpfr -with-gmp=/usr/local/gmp
make && make install
cd ..
rm -rf mpc*

#编译安装gettext
cd /root
wget https://ghproxy.com/https://github.com/loosink/Aria2Das/releases/download/2.2.2/gettext-0.21.zip
unzip gettext-0.21.zip
cd gettext-0.21
chmod +x *
./configure
make
make install
rm -rf /bin/gettext /usr/bin/gettext /usr/bin/gettext.sh /usr/lib64/gettext
gettext -V
cd /root
rm -rf gettext*


wget https://ghproxy.com/https://github.com/loosink/Aria2Das/blob/master/Centos6/gcc/autoconf-2.71.zip
unzip autoconf-2.71.zip
cd autoconf-2.71
yum install perl* -y
chmod +x *
./configure
make
make install
rm -rf /usr/bin/autoreconf
rm -rf /usr/bin/autoconf
autoreconf -V
cd /root
rm -rf autoconf*

#编译安装gcc4.8.5
wget https://ghproxy.com/https://github.com/loosink/Aria2Das/releases/download/2.2.2/gcc-4.8.5.tar.bz2
tar -jxf gcc-4.8.5.tar.bz2
cd gcc-4.8.5
chmod +x *
./contrib/download_prerequisites
mkdir gcc-build-4.8.5
cd gcc-build-4.8.5
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/mpc/lib:/usr/local/gmp/lib:/usr/local/mpfr/lib/
../configure --prefix=/usr/local/gcc --enable-threads=posix --disable-checking --disable-multilib --enable-languages=c,c++ --with-gmp=/usr/local/gmp --with-mpfr=/usr/local/mpfr/ --with-mpc=/usr/local/mpc/
#../configure -enable-checking=release -enable-languages=c,c++ -disable-multilib
make
make install
cd /root
rm -rf gcc*

#创建软链接
mv /usr/bin/c++ /usr/bin/c++.bak
ln -s /usr/local/gcc/bin/c++ /usr/bin/c++
mv /usr/bin/g++ /usr/bin/g++.bak
ln -s /usr/local/gcc/bin/g++ /usr/bin/g++
mv /usr/bin/gcc /usr/bin/gcc.bak 
ln -s /usr/local/gcc/bin/gcc /usr/bin/gcc

#备份旧版gcc
#mv /usr/bin/gcc /usr/bin/gcc-4.4.7
#mv /usr/bin/g++ /usr/bin/g++-4.4.7
#echo 'export PATH=$PATH:/usr/local/gcc-4.8.5/bin/' | sudo tee -a /etc/profile



#编译安装aria2c
yum install automake m4 libtool -y
wget https://ghproxy.com/https://github.com/loosink/Aria2Das/blob/master/Centos6/gcc/aria2-1.32.0.zip
unzip aria2-1.32.0.zip
cd aria2-1.32.0
chmod +x *
autoreconf -i
./configure
make
make install
aria2c --version
cd /root
rm -rf aria2-1.32.0*
