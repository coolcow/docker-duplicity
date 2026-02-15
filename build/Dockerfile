FROM ghcr.io/coolcow/entrypoints:latest

# runtime variables
ENV ENTRYPOINT_USER=duplicity \
      ENTRYPOINT_GROUP=duplicity \
      ENTRYPOINT_HOME=/home

# install duplicity

RUN apk --no-cache --update add \
      duplicity

WORKDIR $ENTRYPOINT_HOME

ENTRYPOINT ["/entrypoint_su-exec.sh", "duplicity"]

CMD ["--help"]

#

ARG LABEL_VERSION="latest"
ARG LABEL_BUILD_DATE
ARG LABEL_VCS_REF
ARG LABEL_LICENSE="GPL-3.0"
ARG LABEL_IMAGE_NAME="ghcr.io/coolcow/duplicity"
ARG LABEL_DESCRIPTION="Simple duplicity Docker image based on alpine."
ARG LABEL_URL="https://ghcr.io/coolcow/duplicity"
ARG LABEL_VCS_URL="https://github.com/coolcow/docker-duplicity"
ARG LABEL_MAINTAINER="Jean-Michel Ruiz (coolcow) <mail@coolcow.org>"

# OCI / OpenContainer image labels
LABEL org.opencontainers.image.title=$LABEL_IMAGE_NAME \
      org.opencontainers.image.description=$LABEL_DESCRIPTION \
      org.opencontainers.image.version=$LABEL_VERSION \
      org.opencontainers.image.created=$LABEL_BUILD_DATE \
      org.opencontainers.image.revision=$LABEL_VCS_REF \
      org.opencontainers.image.authors=$LABEL_MAINTAINER \
      org.opencontainers.image.licenses=$LABEL_LICENSE \
      org.opencontainers.image.source=$LABEL_VCS_URL \
      org.opencontainers.image.url=$LABEL_URL

