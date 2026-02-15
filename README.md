# ghcr.io/coolcow/duplicity

Simple, secure, and bandwidth-efficient backups using [Duplicity](http://duplicity.nongnu.org/) in a minimal Alpine-based Docker image.

---

## Overview

This image provides [Duplicity](http://duplicity.nongnu.org/), a tool for encrypted, bandwidth-efficient backups using the rsync algorithm. Duplicity creates encrypted, incremental, and compressed backups, supporting a wide range of local and remote storage backends.

---

## Features

- Based on Alpine Linux for a small footprint
- Runs as non-root by default (user: `duplicity`)
- Secure execution via [docker-entrypoints](https://github.com/coolcow/docker-entrypoints)
- Easily configurable user/group IDs to avoid permission issues
- Supports all Duplicity features and backends

---

## Usage

### Quick Start

```sh
docker run --rm \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v /path/to/data:/data \
  ghcr.io/coolcow/duplicity [duplicity options]
```

By default, the container runs:

- **ENTRYPOINT:** `/entrypoint_su-exec.sh duplicity`
- **CMD:** `--help`

So running the image with no arguments will show the Duplicity help.

### Example: Backup to Local Directory

```sh
docker run --rm \
  -e PUID=$(id -u) -e PGID=$(id -g) \
  -v /path/to/source:/source \
  -v /path/to/backup:/backup \
  ghcr.io/coolcow/duplicity \
  /source file:///backup
```

---

## Configuration

### Environment Variables

| Variable   | Default | Description                                  |
|------------|---------|----------------------------------------------|
| `PUID`     | 1000    | User ID to run duplicity as                  |
| `PGID`     | 1000    | Group ID to run duplicity as                 |
| `ENTRYPOINT_USER`  | duplicity | Internal: user for entrypoint script |
| `ENTRYPOINT_GROUP` | duplicity | Internal: group for entrypoint script|
| `ENTRYPOINT_HOME`  | /home     | Internal: home directory              |

> Set `PUID` and `PGID` to match your host user to avoid permission issues with mounted volumes.

---

## References

- [Duplicity Documentation](http://duplicity.nongnu.org/)
- [docker-entrypoints](https://github.com/coolcow/docker-entrypoints)

---

## Example: Show Duplicity Help

```sh
docker run --rm ghcr.io/coolcow/duplicity
```

---

## License

GPL-3.0. See [LICENSE.txt](LICENSE.txt) for details.