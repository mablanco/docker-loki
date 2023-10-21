FROM python:3.11.3-alpine3.18
ARG LOKI_VERSION=v0.51.0
WORKDIR /app
RUN apk upgrade && \
    apk add --no-cache --virtual .build-deps git build-base linux-headers openssl-dev && \
    git clone --depth 1 https://github.com/Neo23x0/Loki.git -b $LOKI_VERSION . && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del .build-deps
ENTRYPOINT ["python", "loki.py"]
