#!/bin/bash
#编译安装gcc4.8.5
yum install gcc-c++ -y
cd
curl -O https://github.com/loosink/Aria2Das/releases/download/2.2.2/gcc.tar.bz2
tar -jxf gcc.tar.bz2
cd gcc-4.8.5
chmod +x *
./contrib/download_prerequisites
mkdir gcc-build-4.8.5
cd gcc-build-4.8.5
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/mpc/lib:/usr/local/gmp/lib:/usr/local/mpfr/lib/
../configure --prefix=/usr/local/gcc --enable-threads=posix --disable-checking --disable-multilib --enable-languages=c,c++ --with-gmp=/usr/local/gmp --with-mpfr=/usr/local/mpfr/ --with-mpc=/usr/local/mpc/
make
make install
cd
rm -rf gcc*
echo "7.sh运行完毕"
