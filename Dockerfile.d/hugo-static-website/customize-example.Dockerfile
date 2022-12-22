FROM ghcr.io/mazgi/hugo-static-website

LABEL org.opencontainers.image.source="https://github.com/mazgi/docker.hugo-static-website/blob/main/Dockerfile.d/hugo-static-website/customize-example.Dockerfile"

# Set in non-interactive mode.
ARG DEBIAN_FRONTEND=noninteractive

ARG GID=0
ARG UID=0

RUN :\
  # Create a user for development who has the same UID and GID as you.
  && addgroup --gid ${GID} developer || true\
  && adduser --disabled-password --uid ${UID} --gecos '' --gid ${GID} developer || true\
  && echo '%users ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-users\
  && echo '%developer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-developer
