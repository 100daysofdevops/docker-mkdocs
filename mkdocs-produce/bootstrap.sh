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

produce_mkdocs
