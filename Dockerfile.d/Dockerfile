FROM ubuntu:18.04@sha256:de774a3145f7ca4f0bd144c7d4ffb2931e06634f11529653b23eba85aef8e378
LABEL maintainer="docker@mazgi.com"

ENV DOCKERBUILD_HUGO_VERSION="0.57.0"
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update \
  # Install packages
  && apt-get install -y --no-install-recommends apt-utils locales ca-certificates openssh-client curl git \
  && apt-get install -y --no-install-recommends jq python3-pip python3-sphinx nodejs npm \
  # Generate locale(s)
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
  && locale-gen \
  # Upgrade pip
  && pip3 install --upgrade pip && hash -r pip3 && pip3 install setuptools \
  # Install AWS CLI
  && pip3 install awscli \
  # Install Firebase CLI
  && npm install -g firebase-tools \
  # Download and install Hugo
  && curl -LO "https://github.com/gohugoio/hugo/releases/download/v${DOCKERBUILD_HUGO_VERSION}/hugo_extended_${DOCKERBUILD_HUGO_VERSION}_Linux-64bit.deb" \
  && dpkg -i hugo_extended_${DOCKERBUILD_HUGO_VERSION}_Linux-64bit.deb \
  && rm -f hugo_extended_${DOCKERBUILD_HUGO_VERSION}_Linux-64bit.deb \
  # Scan ssh keys for GitHub
  && mkdir -p ~/.ssh/ \
  && ssh-keyscan github.com 2> /dev/null >> ~/.ssh/known_hosts \
  # Clean up
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*
