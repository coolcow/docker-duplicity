# ghcr.io/coolcow/duplicity

A flexible, multi-purpose, and minimal Alpine-based Docker image for [Duplicity](http://duplicity.nongnu.org/).

This image supports two modes: direct `duplicity` command execution (default) and a cron-based scheduler for running backups automatically. It runs as a non-root user and is configurable through runtime environment variables.

---

## Recommended Usage with `docker-compose`

This example demonstrates both modes side-by-side.

**`docker-compose.yml`**
```yaml
version: "3.7"
services:
  # Example 1: Running a one-off duplicity command
  duplicity-command:
    image: ghcr.io/coolcow/duplicity:latest
    command: /source file:///backup
    environment:
      - PUID=1000
      - PGID=1000
    volumes:
      - /path/to/source:/source
      - /path/to/backup:/backup

  # Example 2: Running as a cron scheduler
  duplicity-cron:
    image: ghcr.io/coolcow/duplicity:latest
    restart: unless-stopped
    environment:
      - RUN_MODE=cron
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
    volumes:
      - ./crontab:/crontab:ro
      - /path/to/source:/source
      - /path/to/backup:/backup
      - /path/to/logs:/logs
```

**Example `crontab` file:**
```crontab
# Run a backup every day at 2:00 AM
0 2 * * *    flock -n /tmp/duplicity.lock duplicity /source file:///backup >> /logs/duplicity.log 2>&1
```

---

## Configuration

### Runtime Environment Variables

| Variable        | Default   | Description                                                    |
| --------------- | --------- | -------------------------------------------------------------- |
| `RUN_MODE`      | `duplicity` | Set to `cron` to activate the cron scheduler mode.          |
| `PUID`          | `1000`    | The user ID to run the `duplicity` process as.                |
| `PGID`          | `1000`    | The group ID to run the `duplicity` process as.               |
| `TZ`            | `Etc/UTC` | Timezone for the container, important for correct scheduling. |
| `CROND_CRONTAB` | `/crontab`| Path inside the container for the crontab file.               |

### Build-Time Arguments

Customize the image at build time with `docker build --build-arg <KEY>=<VALUE>`.

| Argument              | Default   | Description                                      |
| --------------------- | --------- | ------------------------------------------------ |
| `ALPINE_VERSION`      | `3.23.3`  | Version of the Alpine base image.                |
| `ENTRYPOINTS_VERSION` | `2.0.0`   | Version of the `coolcow/entrypoints` image.      |

---

## Local Testing

Run the built-in smoke tests locally.

1. `docker build -t ghcr.io/coolcow/duplicity:local-test-build -f build/Dockerfile build`
2. `docker build --build-arg APP_IMAGE=ghcr.io/coolcow/duplicity:local-test-build -f build/Dockerfile.test build`

---

## Deprecation Notice

This image replaces the now-obsolete `ghcr.io/coolcow/duplicity-cron` image. Migrate by using the `RUN_MODE=cron` environment variable.

---

## References

- [Duplicity Documentation](http://duplicity.nongnu.org/)
- [docker-entrypoints](https://github.com/coolcow/docker-entrypoints)

---

## License

GPL-3.0. See [LICENSE.txt](LICENSE.txt) for details.