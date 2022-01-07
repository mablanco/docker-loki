FROM python:3.9.9-alpine3.15
ARG LOKI_VERSION=v0.44.2
WORKDIR /app
RUN apk upgrade && \
    apk add --no-cache --virtual .build-deps git build-base linux-headers openssl-dev && \
    git clone --depth 1 https://github.com/Neo23x0/Loki.git -b $LOKI_VERSION . && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir colorama && \
    apk del .build-deps
ENTRYPOINT ["python", "loki.py"]
