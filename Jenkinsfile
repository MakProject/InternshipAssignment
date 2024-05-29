pipeline {

    agent any

    stages {
        stage('SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/MakProject/InternshipAssignment.git'
            }
        }

        stage('Changing IP in .env') {
            steps {
                script {
                        sh "sed -i 's/\\\$AWS_IP/${AWS_IP}/g' backend/.env frontend/.env.local"
                }
            }
        }

        stage('Building Backend') {
            steps {
                script {
                    dir('backend') {
                        sh 'docker build -t backend .'
                    }
                }
            }
        }
        stage('Building Frontend') {
            steps {
                script {
                    dir('frontend') {
                        sh 'docker build -t frontend .'
                    }
                }
            }
        }
        stage('Deployment') {
            steps {
                script {
                    sh './deployment.sh'
                }
            }
        }
    }
}

