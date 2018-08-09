FROM ubuntu:16.04@sha256:e348fbbea0e0a0e73ab0370de151e7800684445c509d46195aef73e090a49bd6
MAINTAINER "Hidenori MATSUKI <matsuki.hidenori+docker@gmail.com>"

ENV DOCKERBUILD_HUGO_VERSION="0.40.3"

RUN : 'Install packages' \
      && apt update \
      && apt install -y --no-install-recommends ca-certificates openssh-client curl git python3-pip nodejs npm \
      && : 'Install AWS CLI' \
      && pip3 install --upgrade pip && pip3 install setuptools && pip3 install awscli \
      && : 'Install Firebase CLI' \
      && npm install -g firebase-tools \
      && : 'Download and install Hugo' \
      && curl -LO "https://github.com/gohugoio/hugo/releases/download/v${DOCKERBUILD_HUGO_VERSION}/hugo_${DOCKERBUILD_HUGO_VERSION}_Linux-64bit.deb" \
      && dpkg -i hugo_${DOCKERBUILD_HUGO_VERSION}_Linux-64bit.deb \
      && : 'Scan ssh keys for GitHub' \
      && mkdir -p ~/.ssh/ \
      && ssh-keyscan github.com 2> /dev/null >> ~/.ssh/known_hosts \
      && : 'Clean up' \
      && apt clean

ENTRYPOINT ["/bin/bash"]
