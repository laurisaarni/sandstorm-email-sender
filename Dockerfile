FROM i386/ubuntu:14.04

MAINTAINER Lauri Saarni <lauri@web-essentials.asia>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8
ENV SANDSTORM_VERSION 1.3.0

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      vim.tiny wget curl sudo net-tools pwgen \
      git-core logrotate software-properties-common && \
    locale-gen en_US en_US.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget https://packages.web-essentials.asia/boxes/vendor/sandstorm-newsletter-sender_${SANDSTORM_VERSION}_i386.deb

RUN dpkg --force-all -i /tmp/sandstorm-newsletter-sender_${SANDSTORM_VERSION}_i386.deb && \
    apt-get install

COPY Configuration/sandstorm-newsletter-sender /etc/default/sandstorm-newsletter-sender

COPY Scripts/EntryPoint/mailer.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3000:3000

ENTRYPOINT ["/entrypoint.sh"]
