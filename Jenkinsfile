pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "alexaa123/student-app:latest"
        APP_SERVER_IP = "3.87.76.80"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'Main', url: 'https://github.com/Pritam280/student-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push $DOCKER_IMAGE'
            }
        }

        stage('Deploy to App Server') {
            steps {
                sshagent(['app-server-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ec2-user@$APP_SERVER_IP '
                      docker pull $DOCKER_IMAGE
                      docker stop student-app || true
                      docker rm student-app || true
                      docker run -d -p 5000:5000 --name student-app $DOCKER_IMAGE
                    '
                    """
                }
            }
        }
    }
}
