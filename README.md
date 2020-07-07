# docker-loki

Docker image for Loki, a Simple IOC Scanner (<https://github.com/Neo23x0/Loki>).

This image is built upon the official Alpine-based Python image.

## How to use this image

Create a volume for Loki's signatures:

    $ docker volume create loki_signatures

Scan a directory:

    $ docker run -it --rm -v loki_signatures:/app/signature-base -v <directory>:/app/scan  mablanco/loki -p /app/scan

In order to be able to scan different directories in each invocation, you need to use the `--rm` parameter to delete the container after its execution and then mount a different directory with the `-v` parameter. Using the volume prevents Loki from downloading the signatures each time the container is run.
