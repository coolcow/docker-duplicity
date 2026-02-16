#!/bin/sh

set -e

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
