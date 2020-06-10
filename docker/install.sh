#!/bin/bash -Eeu

apt-get update

cd /usr/local

apt-get install --yes \
  xz-utils \
  build-essential \
  curl

rm -rf /var/lib/apt/lists/*

curl -SL http://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.0/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz \
  | tar -xJC .

apt-get remove --yes curl

mv clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04 clang_10.0.0

apt-get update --yes
apt-get install --yes gcovr
