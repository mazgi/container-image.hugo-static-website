FROM ubuntu:18.04@sha256:de774a3145f7ca4f0bd144c7d4ffb2931e06634f11529653b23eba85aef8e378
MAINTAINER "Hidenori MATSUKI <matsuki.hidenori+docker@gmail.com>"

ENV DOCKERBUILD_HUGO_VERSION="0.54.0"
ENV DEBIAN_FRONTEND="noninteractive"

RUN : 'Install packages' \
      && apt update \
      && apt install -y --no-install-recommends ca-certificates openssh-client curl git jq python3-pip python3-sphinx nodejs npm \
      && : 'Upgrade pip' \
      && pip3 install --upgrade pip && hash -r pip3 && pip3 install setuptools \
      && : 'Install AWS CLI' \
      && pip3 install awscli \
      && : 'Install Firebase CLI' \
      && npm install -g firebase-tools \
      && : 'Download and install Hugo' \
      && curl -LO "https://github.com/gohugoio/hugo/releases/download/v${DOCKERBUILD_HUGO_VERSION}/hugo_extended_${DOCKERBUILD_HUGO_VERSION}_Linux-64bit.deb" \
      && dpkg -i hugo_extended_${DOCKERBUILD_HUGO_VERSION}_Linux-64bit.deb \
      && : 'Scan ssh keys for GitHub' \
      && mkdir -p ~/.ssh/ \
      && ssh-keyscan github.com 2> /dev/null >> ~/.ssh/known_hosts \
      && : 'Clean up' \
      && apt clean
