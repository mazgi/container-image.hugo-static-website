FROM ubuntu:22.04

LABEL org.opencontainers.image.source="https://github.com/mazgi/docker.hugo-static-website"

# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETARCH
ARG TARGETPLATFORM
# Set in non-interactive mode.
ARG DEBIAN_FRONTEND=noninteractive

ARG HUGO_VERSION=0.119.0

RUN echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends\
  && apt-get update\
#   && :
# RUN :\
  && : Set up locales\
  && apt-get install --assume-yes locales procps dialog\
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen\
  && locale-gen\
#   && :
# RUN :\
  && : Install basic packages\
  && apt-get install --assume-yes sudo apt-utils curl dnsutils git jq openssh-client tmux unzip zsh\
  && apt-get install --assume-yes apt-transport-https ca-certificates gnupg gnupg2 rsync software-properties-common\
  && apt-get install --assume-yes python3-pip python3-setuptools\
  && apt-get install --assume-yes nodejs npm\
  # for `pip3 install cryptography`
  # see: https://cryptography.io/en/latest/installation/#debian-ubuntu
  && apt-get install --assume-yes build-essential cargo libssl-dev libffi-dev python3-dev\
#   && :
# RUN :\
  && : APT Repository [Docker]\
  # See https://docs.docker.com/engine/install/ubuntu/
  && curl --fail --silent --show-error --location https://download.docker.com/linux/ubuntu/gpg\
  | gpg --no-default-keyring --keyring /usr/share/keyrings/docker-archive-keyring.gpg --import -\
  && echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"\
  | tee /etc/apt/sources.list.d/docker.list > /dev/null\
#   && :
# RUN :\
  && : APT Repository [Azure]\
  # See https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
  && curl --fail --silent --show-error --location https://packages.microsoft.com/keys/microsoft.asc\
  | gpg --no-default-keyring --keyring /usr/share/keyrings/microsoft-keyring.gpg --import -\
  && echo\
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft-keyring.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main"\
  | tee /etc/apt/sources.list.d/azure-cli.list > /dev/null\
  && echo\
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft-keyring.gpg] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod/ $(lsb_release -cs) main"\
  | tee /etc/apt/sources.list.d/microsoft-debian-prod.list > /dev/null\
#   && :
# RUN :\
  && : APT Repository [Google Cloud]\
  # See https://cloud.google.com/sdk/docs/install#deb
  && curl --fail --silent --show-error --location https://packages.cloud.google.com/apt/doc/apt-key.gpg\
  | gpg --no-default-keyring --keyring /usr/share/keyrings/cloud.google.gpg --import -\
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main"\
  | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list\
#   && :
# RUN :\
  && : Install Packages from Added Repositories\
  && apt-get update\
  # # Azure
  # && apt-get install --assume-yes azure-cli powershell\
  # && pwsh -c 'Install-Module -AllowClobber -Force -Name Az'\
  # Docker
  && apt-get install --assume-yes docker-ce docker-ce-cli containerd.io docker-compose-plugin\
  # Google Cloud
  && apt-get install --assume-yes google-cloud-sdk\
  # for `gsutil signurl`
  && pip3 install pyopenssl\
#   && :
# RUN :\
  && : Install AWS CLI v2 for ${TARGETARCH}\
  && test "${TARGETARCH}" = "amd64" && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip || : NOP\
  && test "${TARGETARCH}" = "arm64" && curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o /tmp/awscliv2.zip || : NOP\
  && unzip /tmp/awscliv2.zip -d /tmp/\
  && /tmp/aws/install\
  && rm -rf /tmp/awscliv2.zip /tmp/aws/\
#   && :
# RUN :\
  && : Install Firebase CLI\
  && npm install -g firebase-tools\
#   && :
# RUN :\
  && : Scan GitHub ssh keys\
  && mkdir -p ~/.ssh/\
  && ssh-keyscan github.com 2> /dev/null >> ~/.ssh/known_hosts\
#   && :
# RUN :\
  && : Install Hugo\
  && curl -o hugo_extended.deb -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.deb\
  && dpkg -i hugo_extended.deb\
  && rm -f hugo_extended.deb\
#   && :
# RUN :\
  && : Place empty .zshrc\
  && touch /etc/skel/.zshrc\
#   && :
# RUN :\
  && : Clean up\
  && apt-get clean autoclean\
  && apt-get autoremove --yes\
  && rm -rf /tmp/*\
  && rm -rf /var/lib/apt/\
  && rm -rf /var/log/*\
  && :
