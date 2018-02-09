#!/bin/bash
set -e

# The base image for clang++ is Ubuntu 16.04
# I tried Ubuntu 18.04 but it caused problems for googlemock ...
# relocation R_X86_64_32 against `.rodata.str1.1' can not be used
# when making a shared object; recompile with -fPIC
# /usr/bin/ld: final link failed: Nonrepresentable section on output

# needed for apt-add-repository on line 15
apt-get install --yes software-properties-common

apt-get install --yes wget
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main"
apt-get update

apt-get install --yes clang-5.0
update-alternatives --install /usr/bin/cc  cc  /usr/bin/clang-5.0   100
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-5.0 100

apt-get remove --yes wget