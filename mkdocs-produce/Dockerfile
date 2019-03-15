FROM alpine:latest

RUN \
    apk add --update \
        bash \
        python2 \
        python2-dev \
        py-setuptools; \
    easy_install-2.7 pip && \
    pip install mkdocs

ADD . /

RUN chmod +x /bootstrap.sh

WORKDIR /mkdocs/

EXPOSE 8000

ENTRYPOINT ["/bootstrap.sh"]
