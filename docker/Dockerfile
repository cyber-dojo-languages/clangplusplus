FROM  cyberdojofoundation/ubuntu-build-essential:18.04
LABEL maintainer=jon@jaggersoft.com

RUN apt-get update \
 && apt-get install --yes clang \
 && update-alternatives --install /usr/bin/cc  cc  /usr/bin/clang   100 \
 && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100
