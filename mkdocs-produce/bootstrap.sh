#!/bin/bash

set -eu

# Produces the Mk Docs website from reading the .md files in the docs directory.
produce_mkdocs() {
    # If there is no existing configuration, create a new Mk Docs website.
    if [ ! -e mkdocs.yml ]; then
        echo "No previous config. Starting fresh installation."
        mkdocs new .
    fi
}

# Serves the Mk Docs website onto localhost:8000.
serve_mkdocs() {
    echo "Starting MKDocs"
    mkdocs serve -a 0.0.0.0:8000
}

produce_mkdocs
serve_mkdocs
