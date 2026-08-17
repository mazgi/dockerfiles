FROM ubuntu:26.04

LABEL maintainer="docker@mazgi.com"
LABEL org.opencontainers.image.source="https://github.com/mazgi/container-images/blob/main/Dockerfiles.d/node-webapp.development/Dockerfile"

# Set in non-interactive mode.
ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_VERSION=20
# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETARCH
ARG TARGETPLATFORM

WORKDIR /workspace

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
  && apt-get install --assume-yes vim\
#   && :
# RUN :\
  && : Install middleware clients\
  && apt-get install --assume-yes default-mysql-client redis-tools\
#   && :
# RUN :\
  && : Install Node.js ${NODE_VERSION}\
  && curl --fail --silent --show-error --location "https://deb.nodesource.com/setup_${NODE_VERSION}.x"\
  | bash -\
  && apt-get install -y nodejs\
#   && :
# RUN :\
  && : Install development NPM packages\
  && npm install --global\
  concurrently\
  # see https://github.com/npm/cli/issues/3438
  npm\
  npm-check-updates\
  pnpm\
  sort-package-json\
  && npm cache clean -force\
#   && :
# RUN :\
  && : Install starship\
  && curl --output "/tmp/starship.install.sh" --fail --silent --show-error --location "https://starship.rs/install.sh"\
  && sh /tmp/starship.install.sh --yes\
  && rm -f /tmp/starship.install.sh\
#   && :
# RUN :\
  && : Clean up\
  && apt-get clean autoclean\
  && apt-get autoremove --yes\
  && rm -rf /tmp/*\
  && rm -rf /var/lib/apt/\
  && rm -rf /var/log/*\
  && :
