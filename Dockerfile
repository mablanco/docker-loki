FROM python:3.13.0-alpine3.20
ARG LOKI_VERSION=0.51.0
WORKDIR /app
RUN apk upgrade --no-cache && \
    apk add --no-cache --virtual .build-deps git build-base linux-headers openssl-dev && \
    git clone --depth 1 https://github.com/Neo23x0/Loki.git -b v$LOKI_VERSION . && \
    sed -i "s/__version__ =.*/__version__ = '$LOKI_VERSION'/" lib/lokilogger.py && \
    pip install -r requirements.txt && \
    apk del .build-deps
ENTRYPOINT ["python", "loki.py"]
