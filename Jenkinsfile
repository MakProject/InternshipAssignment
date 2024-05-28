pipeline {
    
    agent any

    stages {
        stage('SCM') {
            steps {
                script {
                    checkout scm
                }
            }
        }
        stage('Building Backend') {
            steps {
                script {
                    dir('backend') {
                        sh 'docker build .'
                    }
                }
            }
        }
        stage('Building Frontend') {
            steps {
                script {
                    dir('frontend') {
                        sh 'docker build .'
                    }
                }
            }
        }
        stage('Deployment') {
            steps {
                script {
                    sh 'docker compose up -d'
                }
            }
        }
    }
}

