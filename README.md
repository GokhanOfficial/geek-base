# geek-base

Shared Alpine runtime base image for small Python media services.

```
docker pull gokhanofficial/geek-base:latest
```

| Included | Why |
|---|---|
| Python 3.12 (Alpine 3.24) | runtime |
| ffmpeg / ffprobe | thumbnails, metadata |
| rclone | serve cloud storage over loopback WebDAV/HTTP |
| aria2, su-exec | downloads, dropping root in entrypoints |
| postgresql-client | `pg_dump` / `pg_restore` backups |
| tzdata, ca-certificates | |

Also sets `PYTHONUNBUFFERED=1`, `PYTHONDONTWRITEBYTECODE=1`, `PIP_NO_CACHE_DIR=1`,
`PIP_DISABLE_PIP_VERSION_CHECK=1`.

Several services on one host built `FROM gokhanofficial/geek-base` store these
layers only once (~450 MB uncompressed instead of per image).

## Tags

- `latest` — most recent build
- `YYYY.MM` — monthly snapshot, for pinning

Rebuilt automatically on the 1st of every month (`.github/workflows/publish.yml`)
to pick up Alpine security fixes and Python 3.12 patch releases. Downstream
images get them with `docker compose build --pull`.

## Usage

```dockerfile
FROM gokhanofficial/geek-base:latest
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
```

## Publishing setup

The workflow pushes to Docker Hub when these repository secrets exist:
`DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN` (a Docker Hub access token with
Read & Write scope). Without them it only builds.

## License

MIT
