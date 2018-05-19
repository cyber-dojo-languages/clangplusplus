FROM  cyberdojofoundation/ubuntu-build-essential:16.04
LABEL maintainer=jon@jaggersoft.com

ADD install.sh /

RUN /install.sh && \
    rm -f /install.sh

RUN apt-get install --yes python-pip \
 && pip install gcovr
