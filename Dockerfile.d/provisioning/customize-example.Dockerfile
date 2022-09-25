FROM ghcr.io/mazgi/provisioning

LABEL org.opencontainers.image.source="https://github.com/mazgi/dockerfiles/blob/main/Dockerfile.d/provisioning/with-user.Dockerfile"

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive

ARG DOCKER_GID
ARG GID=0
ARG UID=0
ENV DOCKER_GID=${DOCKER_GID}
ENV GID=${GID:-0}
ENV UID=${UID:-0}

COPY rootfs /
RUN :\
  && cd /usr/local/bin\
  && ln -fs docker-entrypoint.keep-running.zsh echoDebug\
  && ln -fs docker-entrypoint.keep-running.zsh echoInfo\
  && ln -fs docker-entrypoint.keep-running.zsh echoWarn\
  && ln -fs docker-entrypoint.keep-running.zsh echoErr\
  && ln -fs docker-entrypoint.keep-running.zsh getStatusFilePath\
  && ln -fs docker-entrypoint.keep-running.zsh updateStatusToSucceeded\
  && ln -fs docker-entrypoint.keep-running.zsh updateStatusToFailed\
  && :

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.keep-running.zsh" ]
CMD [ "echoWarn", "This message is the default CMD defined in the Dockerfile." ]

HEALTHCHECK --interval=2s --timeout=1s --retries=2 --start-period=5s\
 CMD jq -e ". | select(.succeeded)" $(getStatusFilePath)

RUN :\
  # Create a user for development who has the same UID and GID as you.
  && useradd --comment '' --create-home --gid users --uid ${UID} developer\
  && groupadd --gid ${GID} developer\
  && usermod --append --groups developer developer || true\
  # Append docker group
  && bash -c "test -n \"${DOCKER_GID}\" && groupadd --gid ${DOCKER_GID} docker"\
  && usermod --append --groups docker developer 2> /dev/null || true\
  # It will be duplicate UID or GID with "node" user when your UID==1000 or GID==100.
  && echo '%users ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-users\
  && echo '%developer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-developer

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=