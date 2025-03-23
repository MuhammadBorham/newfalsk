pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mborham6/newflaskapp' // Replace with your desired image name
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
    }
}
