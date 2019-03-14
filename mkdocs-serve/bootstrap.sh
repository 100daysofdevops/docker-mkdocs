#!/bin/bash

set -eu

# Serves the Mk Docs website onto localhost:8000.
serve_mkdocs() {
    echo "Starting MKDocs"
    mkdocs serve -a 0.0.0.0:8000
}

serve_mkdocs
