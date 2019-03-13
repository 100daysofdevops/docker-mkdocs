FROM alpine:latest

RUN \
    apk add --update \
        bash \
        python2 \
        python2-dev \
        py-setuptools; \
    easy_install-2.7 pip && \
    pip install mkdocs

COPY / /

RUN chmod +x /mkdockerize.sh

WORKDIR /

EXPOSE 8000

ENTRYPOINT ["/mkdockerize.sh"]
