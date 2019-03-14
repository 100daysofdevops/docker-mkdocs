#!/bin/bash
# Wrapper script that runs both produce and serve options of the Docker container,
# taking care of passing the arguments from the command line into the container.

set -x

# Copy the pages into the mkdocs-produce directory before it is built.
cp -rf docs/ mkdocs-produce/docs/

# Move the mkdocs.yml file to the root of the mkdocs-produce directory. The
# structure shown on the MKDocs documentation shows that mkdocs.yml is at the root.
mv mkdocs-produce/docs/mkdocs.yml mkdocs-produce/mkdocs.yml

cd mkdocs-produce/

# Build the mkdocs-produce Docker image.
docker build -t daduang/mkdocs-produce .

# Create a container based on the mkdocs-produce Docker image and after files from
# /docs have been moved from our local directory to the container.
docker container create --name mkdocs-container daduang/mkdocs-produce

# Create a snapshot of mkdocs-produce and save it as mkdocs.tar.gz. By saving
# mkdocs-produce as a file instead of streaming through STDIN, other Docker projects
# may be able to import it and make use of it.
docker container export mkdocs-container | gzip > ../mkdocs-serve/mkdocs.tar.gz

# Remove the mkdocs-container as it is not needed anymore.
docker container rm mkdocs-container

cd ../mkdocs-serve/

# Import the saved mkdocs.tar.gz file and give it a label of 'imported'.
docker import mkdocs.tar.gz mkdocs-container:imported

# We need to build the mkdocs-serve image again even though we imported
# from the mkdocs.tar.gz from mkdocs-produce.
docker build -t daduang/mkdocs-serve .

# Run the mkdocs-serve Docker image. The MKDocs static website can be
# reached at localhost:8000.
docker run -ti --rm -p 8000:8000 --name mkdocs-serve daduang/mkdocs-serve

cd ..

# Remove the .md pages, mkdocs.yml, and mkdocs.tar.gz from the mkdocs-produce and
# mkdocs-serve directories to ensure a clean state every time this script is run.
rm -rf mkdocs-produce/docs/
rm mkdocs-produce/mkdocs.yml
rm mkdocs-serve/mkdocs.tar.gz
