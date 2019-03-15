pipeline {
    agent {
        docker {
            image ''
        }
    }

    stages {
        stage('build') {
            steps {
                echo 'Building...'
                sh label: '', script: '''cp -rf mkdocs mkdocs-produce/mkdocs/
                                         cd mkdocs-produce/
                                         docker build -t daduang/mkdocs-produce .
                                         docker container create --name mkdocs-container daduang/mkdocs-produce
                                         docker container export mkdocs-container | gzip > ../mkdocs-serve/mkdocs.tar.gz
                                         docker container rm mkdocs-container
                                         cd ../mkdocs-serve/
                                         docker import mkdocs.tar.gz mkdocs-container:imported
                                         docker build -t daduang/mkdocs-serve .
                                         '''
            }
        }
    }
}
Browser Connected: http://localhost:8000/
