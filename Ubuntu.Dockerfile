ARG OS_VERSION=latest

FROM ubuntu:$OS_VERSION

LABEL maintainer "https://github.com/daniccan"

RUN apt-get update && apt-get -y install \
    ca-certificates \
    curl

# Ubuntu 18.04+ maps gnupg to version 2.x instead of version 1.x
# Fixes gpg: keyserver receive failed: Server indicated a failure
RUN (apt-get -y install gnupg1 && echo "alias gpg=gpg1" >> ~/.bashrc && source ~/.bashrc) || apt-get -y install gnupg

ENV USERNAME ubuntu
ENV GOSU_VERSION 1.11
ENV GOSU_DOWNLOAD_URL https://github.com/tianon/gosu/releases/download
ENV GOSU_BINARY "${GOSU_DOWNLOAD_URL}/${GOSU_VERSION}/gosu"
ENV GPG_KEY B42F6819007F00F88E364FD4036A9C25BF357DD4

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY"

RUN curl -o /usr/local/bin/gosu -SL "$GOSU_BINARY-$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && curl -o /usr/local/bin/gosu.asc -SL "$GOSU_BINARY-$(dpkg --print-architecture | awk -F- '{ print $NF }').asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
