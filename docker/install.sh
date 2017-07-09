#!/bin/bash

readonly CLANG_VERSION=4.0.0
readonly OS_VERSION=14.04

apt-get update
apt-get install -y wget

wget http://releases.llvm.org/${CLANG_VERSION}/clang+llvm-${CLANG_VERSION}-x86_64-linux-gnu-ubuntu-${OS_VERSION}.tar.xz
tar -xvf clang+llvm-${CLANG_VERSION}-x86_64-linux-gnu-ubuntu-${OS_VERSION}.tar.xz
cp -r clang+llvm-${CLANG_VERSION}-x86_64-linux-gnu-ubuntu-${OS_VERSION}/* /usr/

# Make clang the default compiler
update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100

# Clean up to make the image smaller
rm -rf clang+llvm-${CLANG_VERSION}-x86_64-linux-gnu-ubuntu-${OS_VERSION}
rm -f  clang+llvm-${CLANG_VERSION}-x86_64-linux-gnu-ubuntu-${OS_VERSION}.tar.xz
