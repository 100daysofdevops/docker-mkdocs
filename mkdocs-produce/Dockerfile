FROM alpine:latest

ADD . /

RUN \
    apk add --update \
        bash \
        python2 \
        python2-dev \
        py-setuptools; \
    easy_install-2.7 pip && \
    pip install mkdocs \
    chmod +x /bootstrap.sh

WORKDIR /

EXPOSE 8000

ENTRYPOINT ["/bootstrap.sh"]
