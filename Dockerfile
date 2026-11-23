# geek-base — shared Alpine runtime base for small Python media services.
#
# Contents: Python 3.12 (Alpine), ffmpeg/ffprobe, rclone, aria2, su-exec,
# postgresql-client, tzdata, ca-certificates.
#
# Rebuilt monthly by GitHub Actions so Alpine security fixes and Python 3.12
# patch releases are picked up. Tags: `latest` and `YYYY.MM`.
FROM python:3.12-alpine3.24

RUN apk add --no-cache ca-certificates tzdata ffmpeg rclone aria2 su-exec postgresql-client \
    && ffmpeg -hide_banner -version | head -n 1 \
    && rclone version | head -n 1

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1
