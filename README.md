# docker.hugo-static-website

[![publish-container-images](https://github.com/mazgi/docker.hugo-static-website/actions/workflows/publish-container-images.yml/badge.svg)](https://github.com/mazgi/docker.hugo-static-website/actions/workflows/publish-container-images.yml)
[![start-stop-containers](https://github.com/mazgi/docker.hugo-static-website/actions/workflows/start-stop-containers.yml/badge.svg)](https://github.com/mazgi/docker.hugo-static-website/actions/workflows/start-stop-containers.yml)

## How to Use

### Write out your IDs and information in the .env file

If you have an old `.env` file, you are able to reset it by removing it.

```console
rm -f .env
```

:information_source: If you are using Linux, write out UID and GID into the `.env` file to let that as exported on Docker Compose as environment variables.

```console
test $(uname -s) = 'Linux' && {
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

## How to update the Hugo version

```shellsession
export HUGO_VERSION=0.72.0
export TAG=hugo-${HUGO_VERSION}-$(date +%Y.%m.0)
sed -i "s/ARG HUGO_VERSION=.*/ARG HUGO_VERSION=${HUGO_VERSION}/" Dockerfile.d/hugo-static-website/Dockerfile
git commit -m "update hugo version to ${HUGO_VERSION}" Dockerfile.d/hugo-static-website/Dockerfile
git tag $TAG
git push origin $TAG
```
