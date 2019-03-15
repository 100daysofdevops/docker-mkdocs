pipeline {
    agent {
        docker {
            image 'python:2.7'
        }
    }

    stages {
        stage('build') {
            steps {
                echo 'Building...'
                sh('./mkdockerize.sh mkdocs')
            }
        }

        stage('test') {
            steps {
                echo 'Testing...'
                sh('curl http://localhost:8000 | grep '200 OK'')
            }
            steps {
                echo 'Closing the build...'
                sh('kill $(ps aux | grep '[d]ocker run' | awk '{print $2}')')
            }
        }
    }
}
