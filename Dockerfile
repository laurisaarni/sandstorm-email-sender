FROM ubuntu:14.04

MAINTAINER Lauri Saarni <lauri@web-essentials.asia>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8
ENV SANDSTORM_VERSION 1.1.0

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      vim.tiny wget curl sudo net-tools pwgen \
      git-core logrotate software-properties-common && \
    locale-gen en_US en_US.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget https://github.com/sandstorm/mailer-daemon/blob/master/sandstorm-newsletter_{SANDSTORM_VERSION}_i386.deb?raw=true && \
    dpkg -i sandstorm-newsletter_{SANDSTORM_VERSION}_i386.deb && \
    apt-get install -f

CMD ["bash"]
