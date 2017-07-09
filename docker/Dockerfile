FROM       cyberdojofoundation/ubuntu-build-essential:14.04
MAINTAINER Byran Wills-Heath <byran@adgico.co.uk>

ENV CXX=clang++ CC=clang

ADD install.sh /
RUN /install.sh && \
    rm -f /install.sh
