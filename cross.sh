#!/bin/sh

cd osdev2

export PREFIX="$(pwd)"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

echo $PREFIX $TARGET $PATH

wget ftp://ftp.gnu.org/gnu/binutils/binutils-2.23.tar.gz
tar -xvf binutils-2.23.tar.gz
mkdir build-binutils
cd build-binutils
../binutils-2.23/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install
cd ..

#prepare GCC for installation
wget https://ftp.gnu.org/gnu/gmp/gmp-5.1.3.tar.lz
wget http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.gz
wget http://multiprecision.org/mpc/download/mpc-1.0.1.tar.gz
tar --lzip -xvf gmp-5.1.3.tar.lz
tar -xvf mpfr-3.1.2.tar.gz
tar -xvf mpc-1.0.1.tar.gz
wget ftp://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.gz
tar -xvf gcc-4.8.2.tar.gz
mv gmp-5.1.3 gcc-4.8.2/gmp
mv mpfr-3.1.2 gcc-4.8.2/mpfr
mv mpc-1.0.1 gcc-4.8.2/mpc

mkdir build-gcc
cd build-gcc
../gcc-4.8.2/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc
