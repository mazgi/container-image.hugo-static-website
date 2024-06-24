# docker.hugo-static-website

![publish-container-images](https://github.com/mazgi/docker.hugo-static-website/workflows/publish-container-images/badge.svg)

```shellsession
export HUGO_VERSION=0.72.0
export TAG=hugo-${HUGO_VERSION}-$(date +%Y.%m.0)
sed -i "s/ARG HUGO_VERSION=.*/ARG HUGO_VERSION=${HUGO_VERSION}/" Dockerfile.d/hugo-static-website/Dockerfile
git commit -m "update hugo version to ${HUGO_VERSION}" Dockerfile.d/hugo-static-website/Dockerfile
git tag $TAG
git push origin $TAG
```
