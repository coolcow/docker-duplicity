# Global build arguments
ARG ENTRYPOINTS_VERSION=2.0.0
ARG ALPINE_VERSION=3.23.3

# Stage to fetch scripts from the versioned entrypoints asset image
FROM ghcr.io/coolcow/entrypoints:${ENTRYPOINTS_VERSION} AS entrypoints

# Main build stage
FROM alpine:${ALPINE_VERSION}

# Runtime environment variables needed by the entrypoint scripts.
ENV ENTRYPOINT_USER=duplicity \
      ENTRYPOINT_GROUP=duplicity \
      ENTRYPOINT_HOME=/home \
      CROND_CRONTAB=/crontab

# install dependencies for duplicity, cron, and script execution
RUN apk --no-cache --update add \
      dcron \
      duplicity \
      shadow \
      su-exec \
    && touch $CROND_CRONTAB

# Copy required scripts from the entrypoints asset image
COPY --from=entrypoints /assets/create_user_group_home.sh /usr/local/bin/
COPY --from=entrypoints /assets/entrypoint_su-exec.sh /usr/local/bin/
COPY --from=entrypoints /assets/entrypoint_crond.sh /usr/local/bin/

# Copy the smart entrypoint
COPY entrypoint.sh /usr/local/bin/

# Make scripts executable
RUN chmod +x /usr/local/bin/*.sh

WORKDIR $ENTRYPOINT_HOME

# The smart entrypoint decides whether to run duplicity directly or start crond.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command if nothing is provided to `docker run`.
# The smart entrypoint will pass this to duplicity.
CMD ["--help"]

#

ARG LABEL_VERSION="latest"
ARG LABEL_BUILD_DATE
ARG LABEL_VCS_REF
ARG LABEL_LICENSE="GPL-3.0"
ARG LABEL_IMAGE_NAME="ghcr.io/coolcow/duplicity"
ARG LABEL_DESCRIPTION="Flexible duplicity Docker image supporting direct command and cron modes."
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

VOLUME $ENTRYPOINT_HOME

