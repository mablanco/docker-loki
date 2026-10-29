# docker-loki

## Description

Docker image for Loki-RS, a high-performance, multi-threaded YARA and IOC scanner (<https://github.com/Neo23x0/Loki-RS>).

This image is built upon the official Debian slim image and ships the prebuilt Linux binaries published with each Loki-RS release (`loki` and `loki-util`), together with the bundled signatures.

## How to use this image

### Show inline help

    docker run --rm mablanco/loki --help

### Create a volume for Loki's signatures

    docker volume create loki_signatures

The first time the volume is mounted, Docker fills it with the signatures bundled in the image.

### Update signatures

    docker run --rm -v loki_signatures:/app/signatures --entrypoint /app/loki-util mablanco/loki update

This downloads the latest [YARA Forge](https://yarahq.github.io/) Core rule set into the volume.

### Scan a directory

    docker run --rm -v loki_signatures:/app/signatures -v <local_directory_to_scan>:/scan:ro -v <local_reports_directory>:/reports mablanco/loki --no-procs --no-tui -f /scan -l /reports/loki.log -j /reports/loki.jsonl

The plain text log, the JSONL log and an HTML report are written to the reports directory. By default Loki-RS only scans file types that usually carry malware; add `--scan-all-files` to scan every file.

`--no-procs` skips process scanning, since a container only sees its own processes. Add `--no-tui` for plain output, which also suits CI pipelines.

## Upgrading from Loki 0.51.0

Image tags up to `v0.51.0-20241026` ship the original Python Loki, which its author has deprecated in favour of Loki-RS. The command line is different (for example, `-p ./scan` is now `-f /scan`) and the signatures volume is mounted at `/app/signatures` instead of `/app/signature-base`, so create a new volume rather than reusing the old one.

## Building the image

    docker build -t mablanco/loki .

The Loki-RS version is set with the `LOKI_VERSION` build argument, and the downloaded release is checked against `LOKI_SHA256` (published next to each release asset as a `.sha256` file). Update both together.
