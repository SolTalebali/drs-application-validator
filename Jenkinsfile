pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                bat 'docker build -t drs-validator .'
            }
        }
        stage('Test') {
            steps {
                bat 'docker run --rm drs-validator'
            }
        }
    }
}
