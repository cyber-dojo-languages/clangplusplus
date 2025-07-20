#!/bin/bash -Eeu

apt-get update

cd /usr/local

apt-get install --yes \
  xz-utils \
  build-essential \
  curl

rm -rf /var/lib/apt/lists/*

curl -SL http://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.8/LLVM-20.1.8-Linux-X64.tar.xz \
  | tar -xJC .

apt-get remove --yes curl

mv LLVM-20.1.8-Linux-X64 clang_20.1.8

apt-get update --yes
apt-get install --yes gcovr
