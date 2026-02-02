FROM python:3.14-alpine3.21 AS builder

WORKDIR /builder

RUN apk add build-base git libxslt-dev libxml2-dev musl-dev gcc g++ libffi-dev
RUN pip install --upgrade pip setuptools
RUN pip install wheel cython pyinstaller
COPY . .
RUN cp ./pkg/solid.spec solid.spec
RUN pip install -r requirements.txt
RUN pyinstaller solid.spec

FROM scratch

COPY --from=builder /builder/dist/solid /solid