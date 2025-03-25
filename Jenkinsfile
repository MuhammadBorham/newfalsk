pipeline {
    agent any
    
    environment {
        // AWS/EKS Config
        AWS_REGION      = "eu-west-1"
        EKS_CLUSTER     = "flask-app-cluster"
        
        // Docker Config
        DOCKER_IMAGE = 'mborham6/jenkins-flask:latest' 
        DOCKER_HUB_CREDENTIALS = 'new-docker-credential'
        DOCKERFILE_PATH = "src/Dockerfile"
        
        // Terraform Config
        TF_STATE_BUCKET = "tf-state-bucket007"
        TF_DIR          = "infra/terraform"
        
        // Kubernetes Config
        K8S_DIR         = "infra/k8s"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/MuhammadBorham/newfalsk.git'
            }
        }

        stage('Terraform Apply') {
            steps {
                dir(TF_DIR) {
                    sh """
                    terraform init -backend-config="bucket=${TF_STATE_BUCKET}"
                    terraform apply -auto-approve
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('src') {  // Build from app directory
                    script {
                        docker.build("${DOCKER_IMAGE}", "-f ${DOCKERFILE_PATH} .")
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', "${env.DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${DOCKER_IMAGE}").push()
                    }
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'Aws_Credentials',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh """
                    aws eks update-kubeconfig --name ${EKS_CLUSTER} --region ${AWS_REGION}
                    kubectl apply -f ${K8S_DIR}  # Deploy from k8s directory
                    """
                }
            }
        }
    }

    post {
        success {
            slackSend(
                channel: '#deployments',
                message: "SUCCESS: ${env.JOB_NAME} deployed to ${EKS_CLUSTER}"
            )
        }
        failure {
            slackSend(
                channel: '#alerts',
                message: "FAILED: ${env.JOB_NAME} build ${env.BUILD_NUMBER}"
            )
        }
    }
}