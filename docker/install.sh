#!/bin/bash -Eeu

cd /usr/local

apt-get install --yes \
  xz-utils \
  build-essential \
  curl

rm -rf /var/lib/apt/lists/*

curl -SL http://releases.llvm.org/9.0.0/clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz \
  | tar -xJC .

apt-get remove --yes curl

mv clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04 clang_9.0.0
