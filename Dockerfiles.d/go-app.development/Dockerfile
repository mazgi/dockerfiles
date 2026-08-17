FROM ubuntu:26.04

LABEL maintainer="docker@mazgi.com"
LABEL org.opencontainers.image.source="https://github.com/mazgi/container-images/blob/main/Dockerfiles.d/go-app.development/Dockerfile"

# Set in non-interactive mode.
ARG DEBIAN_FRONTEND=noninteractive
# https://github.com/go-nv/goenv/blob/master/ENVIRONMENT_VARIABLES.md
# > if GOENV_GOMOD_VERSION_ENABLE is set to 1, it will try to use the project's go.mod file to get the version.
ENV GOENV_GOMOD_VERSION_ENABLE=1
# https://go.dev/dl/
ARG GO_VERSIONS=1.25.3,1.24.9
# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETARCH
ARG TARGETPLATFORM

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
  && apt-get install --assume-yes inotify-tools\
#   && :
# RUN :\
  && : Install Go using goenv\
  && git clone --depth=1 https://github.com/go-nv/goenv.git /usr/local/goenv\
  && ls -1 /usr/local/goenv/bin/ | xargs -IB ln -s /usr/local/goenv/bin/B /usr/local/bin/B\
  # Install Go via goenv
  && echo $GO_VERSIONS | tr ',' '\n' | xargs -IV goenv install V\
  # use the beginning version on the list
  && goenv global ${GO_VERSIONS%%,*}\
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

COPY rootfs /
