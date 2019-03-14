# Use the exported container from mkdocs-produce.
FROM mkdocs-container:imported

ADD . /

RUN chmod +x /bootstrap.sh

WORKDIR /

EXPOSE 8000

ENTRYPOINT ["/bootstrap.sh"]
