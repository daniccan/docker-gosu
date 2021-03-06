ARG OS_VERSION=latest

FROM centos:$OS_VERSION

LABEL maintainer "https://github.com/daniccan"

RUN yum -y update && yum -y install \
    gnupg \
    ca-certificates \
    curl

ENV USERNAME centos
ENV GOSU_VERSION 1.11
ENV GOSU_DOWNLOAD_URL https://github.com/tianon/gosu/releases/download
ENV GOSU_BINARY "${GOSU_DOWNLOAD_URL}/${GOSU_VERSION}/gosu"
ENV GPG_KEY B42F6819007F00F88E364FD4036A9C25BF357DD4

RUN curl -o /usr/local/bin/gosu -SL "$GOSU_BINARY-amd64" \
    && curl -o /usr/local/bin/gosu.asc -SL "$GOSU_BINARY-amd64.asc" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
