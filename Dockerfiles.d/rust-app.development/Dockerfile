FROM ubuntu:26.04

LABEL maintainer="docker@mazgi.com"
LABEL org.opencontainers.image.source="https://github.com/mazgi/container-images/blob/main/Dockerfiles.d/rust-app.development/Dockerfile"

# Set in non-interactive mode.
ARG DEBIAN_FRONTEND=noninteractive
# https://www.rust-lang.org/tools/install
ARG RUST_VERSION=1.85.0
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
  && : Install build dependencies for Rust\
  && apt-get install --assume-yes build-essential pkg-config libssl-dev\
#   && :
# RUN :\
  && : Install Rust via rustup\
  && export RUSTUP_HOME=/usr/local/rustup\
  && export CARGO_HOME=/usr/local/cargo\
  && curl --proto '=https' --tlsv1.2 --fail --silent --show-error --location "https://sh.rustup.rs"\
  | sh -s -- -y --default-toolchain ${RUST_VERSION} --profile default\
  && chmod -R a+w /usr/local/rustup /usr/local/cargo\
  && ls -1 /usr/local/cargo/bin/ | xargs -IB ln -s /usr/local/cargo/bin/B /usr/local/bin/B\
#   && :
# RUN :\
  && : Install development tools\
  && cargo install cargo-watch\
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

ENV RUSTUP_HOME=/usr/local/rustup
ENV CARGO_HOME=/usr/local/cargo

COPY rootfs /
