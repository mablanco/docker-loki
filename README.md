# docker-loki

## Description

Docker image for Loki, a simple IOC and YARA scanner (<https://github.com/Neo23x0/Loki>).

This image is built upon the official Alpine-based Python image.

## How to use this image

### Show inline help

    docker run -it --rm mablanco/loki -h

### Create a volume for Loki's signatures

    docker volume create loki_signatures

### Scan a directory

    docker run -it --rm -v loki_signatures:/app/signature-base -v <directory>:/app/scan mablanco/loki -p /app/scan

In order to be able to scan different directories in each invocation, it's advisable to use the `--rm` parameter to delete the container after its execution as it's not needed anymore. You can then scan another directory mounting it with the `-v` parameter. Don't forget to also mount the `loki_signatures` volume to prevent Loki from downloading the signatures each time a container is run.

### Update signatures

    docker run -it --rm -v loki_signatures:/app/signature-base mablanco/loki --update
