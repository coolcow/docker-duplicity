#!/bin/sh

set -e

TARGET_UID=${DUPLICITY_UID:-1000}
TARGET_GID=${DUPLICITY_GID:-1000}
TARGET_REMAP_IDS=${DUPLICITY_REMAP_IDS:-1}
TARGET_USER=${DUPLICITY_USER:-duplicity}
TARGET_GROUP=${DUPLICITY_GROUP:-duplicity}
TARGET_HOME=${DUPLICITY_HOME:-/home/duplicity}
TARGET_SHELL=${DUPLICITY_SHELL:-/bin/sh}

export TARGET_UID
export TARGET_GID
export TARGET_REMAP_IDS
export TARGET_USER
export TARGET_GROUP
export TARGET_HOME
export TARGET_SHELL

case "${RUN_MODE}" in
  cron)
    echo "Starting in cron daemon mode."
    exec /usr/local/bin/entrypoint_crond.sh "$@"
    ;;
  *)
    echo "Starting in direct command mode (default)."
    exec /usr/local/bin/entrypoint_su-exec.sh duplicity "$@"
    ;;
esac
