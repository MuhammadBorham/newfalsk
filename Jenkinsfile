pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mborham6/newflaskapp'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/MuhammadBorham/newfalsk.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image("${env.DOCKER_IMAGE}").push()
                    }
                }
            }
        }
    }
}
