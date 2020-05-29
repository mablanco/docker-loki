FROM python:2.7.18-alpine3.11
ARG LOKI_VERSION=v0.30.7
WORKDIR /app
RUN apk add --update --no-cache git && \
    git clone https://github.com/Neo23x0/Loki.git -b $LOKI_VERSION . && \
    apk add --no-cache --virtual .build-deps build-base linux-headers openssl-dev && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir pycrypto && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/*
ENTRYPOINT ["python", "loki.py"]
