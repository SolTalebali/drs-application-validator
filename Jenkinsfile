pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                bat 'docker build -t drs-validator c:\\Coding\\drs-application-validator'
            }
        }
        stage('Test') {
            steps {
                bat 'docker run --rm drs-validator'
            }
        }
    }
}
