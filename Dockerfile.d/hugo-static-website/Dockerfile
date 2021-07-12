FROM debian:10

LABEL org.opencontainers.image.source="https://github.com/mazgi/docker.hugo-static-website"

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive

ARG HUGO_VERSION=0.81.0
ENV HUGO_VERSION=${HUGO_VERSION}

RUN echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends\
  && apt-get update\
  # 
  # Set up locales
  && apt-get install --assume-yes locales procps dialog\
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen\
  && locale-gen\
  #
  # Install basic packages
  && apt-get install --assume-yes sudo apt-utils curl dnsutils git jq openssh-client tmux unzip zsh\
  && apt-get install --assume-yes apt-transport-https ca-certificates gnupg gnupg2 rsync software-properties-common\
  && apt-get install --assume-yes python3-pip python3-setuptools\
  && apt-get install --assume-yes nodejs npm\
  # for `pip3 install cryptography`
  # see: https://cryptography.io/en/latest/installation/#debian-ubuntu
  && apt-get install --assume-yes build-essential cargo libssl-dev libffi-dev python3-dev\
  # 
  # Install Docker CLI
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -\
  && add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable"\
  && apt-get update\
  && apt-get install --assume-yes docker-ce-cli\
  # 
  # Install AWS CLI v.2
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"\
  && unzip /tmp/awscliv2.zip -d /tmp/\
  && /tmp/aws/install\
  && rm -rf /tmp/awscliv2.zip /tmp/aws/\
  #
  # Install Firebase CLI
  && npm install -g firebase-tools\
  # 
  # Install Google Cloud SDK
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -\
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main"\
  | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list\
  && apt-get update\
  && apt-get install --assume-yes google-cloud-sdk\
  # for gsutil signurl
  && pip3 install pyopenssl\
  # 
  # Scan GitHub ssh keys
  && mkdir -p ~/.ssh/\
  && ssh-keyscan github.com 2> /dev/null >> ~/.ssh/known_hosts\
  # 
  # Install Hugo
  && curl -LO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.deb"\
  && dpkg -i hugo_extended_${HUGO_VERSION}_Linux-64bit.deb\
  && rm -f hugo_extended_${HUGO_VERSION}_Linux-64bit.deb\
  #
  # Place empty .zshrc
  && touch /etc/skel/.zshrc\
  # 
  # Clean up\
  && apt-get autoremove -y\
  && apt-get clean -y\
  && rm -rf /var/lib/apt/lists/*

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=
