FROM  cyberdojofoundation/ubuntu-build-essential:18.04
LABEL maintainer=byran@adgico.co.uk

ARG VERSION=5.0

ENV CXX=clang++-${VERSION}
ENV CC=clang-${VERSION}

RUN apt-get update
RUN apt-get install --yes clang-${VERSION}

RUN update-alternatives --install /usr/bin/cc  cc  /usr/bin/clang-${VERSION}   100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-${VERSION} 100

RUN c++ --version | grep -q 5.0.1
