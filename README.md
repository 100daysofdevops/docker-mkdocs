docker-mkdocs

Two functions are split between mkdocs-produce, which reads the local directory containing a MkDocs project, and mkdocs-serve, which serves the generated MkDocs website onto localhost:8000.

Inside mkdocs-produce and mkdocs-serve directories, there are Dockerfiles and bootstrap.sh files that set up and perform the objectives of reading and hosting a MkDocs project.

In order for this project to run correctly, there are only a few steps.
    1. Run the mkdockerize.sh script passing in the directory of your mkdocs files as an argument
        a. ./mkdockerize.sh <directory-of-mkdocs-files>
    2. Navigate to http://localhost:8000 to see the MkDocs-created website.
