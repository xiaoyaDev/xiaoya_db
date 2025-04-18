FROM python:3.13-alpine3.21

ARG BRANCH

ENV TZ=Asia/Shanghai \
    CYCLE=86400 \
    BRANCH=${BRANCH} \
    REPO_URL="https://github.com/xiaoyaDev/xiaoya_db.git" \
    RESTART_AUTO_UPDATE=false

RUN set -ex && \
    apk add --no-cache \
        bash \
        git \
        tini \
        tzdata && \
    apk add --no-cache --virtual=build-dependencies \
        build-base \
        gcc \
        g++ && \
    mkdir /app && \
    git config --global --add safe.directory /app && \
    git clone -b ${BRANCH} ${REPO_URL} /app && \
    python3 -m pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r /app/requirements.txt && \
    apk del --purge build-dependencies && \
    rm -rf \
        /root/.cache \
        /tmp/*

COPY --chmod=755 ./pkg/docker/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["tini", "-g", "--", "/entrypoint.sh"]

CMD ["--media", "/media"]
