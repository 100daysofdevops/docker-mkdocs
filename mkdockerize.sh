#!/bin/bash
# Wrapper script that runs both produce and serve options of the Docker container,
# taking care of passing the arguments from the command line into the container.

set -x

# Copy the pages into the mkdocs-produce directory before it is built.
cp -rf docs/ mkdocs-produce/docs/
# Move the mkdocs.yml file to the root of the mkdocs-produce directory.
mv mkdocs-produce/docs/mkdocs.yml mkdocs-produce/mkdocs.yml

cd mkdocs-produce/

# Build the mkdocs-produce Docker image.
docker build -t daduang/mkdocs-produce .

docker container create --rm -p 8000:8000 --name mkdocs-container daduang/mkdocs-produce
# # Save the mkdocs-produce Docker container as mkdocs.tar.gz.
docker container export mkdocs-container | gzip > ../mkdocs-serve/mkdocs.tar.gz

cd ..

cd mkdocs-serve/
# Import the saved mkdocs.tar.gz file.
docker import mkdocs.tar.gz mkdocs-container

# echo docker build -t daduang/mkdocs-serve mkdocs-serve
# Build the mkdocs-serve Docker image.
# docker build -t daduang/mkdocs-serve mkdocs-serve
# echo docker run -ti --rm -p 8000:8000 --name mkdocs daduang/mkdocs-serve
# Run the mkdocs-serve Docker image. The MKDocs static website can be
# reached at localhost:8000.
docker container start mkdocs-container

cd ..

# Remove the .md pages and mkdocs.yml from the mkdocs-produce directory to
# ensure a clean state every time this script is run.
rm -rf mkdocs-produce/docs/
rm mkdocs-produce/mkdocs.yml
