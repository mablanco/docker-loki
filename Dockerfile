FROM python:3.9.4-alpine3.13
ARG LOKI_VERSION=0.41.0
WORKDIR /app
RUN apk add --update --no-cache git && \
    git clone --depth 1 https://github.com/Neo23x0/Loki.git -b $LOKI_VERSION . && \
    apk add --no-cache --virtual .build-deps build-base linux-headers openssl-dev && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir colorama && \
    apk del .build-deps
ENTRYPOINT ["python", "loki.py"]
