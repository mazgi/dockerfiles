# container-images

My Dockerfile and related resources.

Language|Build Status|Container Images
---|---|---
Go|[![publish-go-app-development-container-images](https://github.com/mazgi/container-images/actions/workflows/publish-go-app-development-container-images.yaml/badge.svg)](https://github.com/mazgi/container-images/actions/workflows/publish-go-app-development-container-images.yaml)|[ghcr.io/mazgi/go-app.development](https://github.com/mazgi/container-images/pkgs/container/go-app.development)
Node.js|[![publish-node-webapp-development-container-images](https://github.com/mazgi/container-images/actions/workflows/publish-node-webapp-development-container-images.yaml/badge.svg)](https://github.com/mazgi/container-images/actions/workflows/publish-node-webapp-development-container-images.yaml)|[ghcr.io/mazgi/node-webapp.development](https://github.com/mazgi/container-images/pkgs/container/node-webapp.development)

## How to Use

### Write out your IDs and information in the .env file

If you have an old `.env` file, you are able to reset it by removing it.

```console
rm -f .env
```

:information_source: If you are using Linux, write out UID, GID, and GID for the `docker` group, into the `.env` file to let that as exported on Docker Compose as environment variables.

```console
test $(uname -s) = 'Linux' && {
  echo -e "DOCKER_GID=$(getent group docker | cut -d : -f 3)"
  echo -e "GID=$(id -g)"
  echo -e "UID=$(id -u)"
} >> .env || :
```

## Supplementary Information

### Environment Variable Names

Environment variable names and uses are as follows.

| Name       | Required on Linux | Value                                                                                                                                   |
| ---------- | ----------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| UID        | **Yes**           | This ID number is used as UID for your Docker user, so this ID becomes the owner of all files and directories created by the container. |
| GID        | **Yes**           | The same as the above UID.                                                                                                              |
| DOCKER_GID | **Yes**           | This ID number is used to provide permission to read and write your docker socket on your local machine from your container.            |
