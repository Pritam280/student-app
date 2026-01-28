pipeline {
    agent any

    environment {
        IMAGE_NAME = "alexaa123/student-app:latest"
        APP_SERVER = "3.87.76.80"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Pritam280/student-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $alexaa123/student-app:latest .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push $alexaa123/student-app:latest'
            }
        }

        stage('Deploy to App Server') {
            steps {
                sshagent(['app-server-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ec2-user@$APP_SERVER << EOF
                    docker pull $alexaa123/student-app:latest
                    docker stop app || true
                    docker rm app || true
                    docker run -d --name app -p 5000:5000 $alexaa123/student-app:latest
                    EOF
                    """
                }
            }
        }
    }
}
