FROM       cyberdojofoundation/ubuntu-build-essential:17.04
MAINTAINER Byran Wills-Heath <byran@adgico.co.uk>

ENV CXX=clang++-4.0 CC=clang-4.0

RUN apt-get update
RUN apt-get install -y clang-4.0

RUN update-alternatives --install /usr/bin/cc  cc  /usr/bin/clang-4.0   100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-4.0 100
