pipeline {
    agent any
 
    environment {
        DOCKER_DEV_REPO = 'ramgai/dev'
        DOCKER_PROD_REPO = 'ramgai/prod'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        BRANCH_NAME = "${env.BRANCH_NAME}"
    }
 
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
 
        stage('Execute Permission to Scripts') {
            steps {
                sh '''
                    chmod +x build.sh
                    chmod +x deploy.sh
                '''
            }
        }
 
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'Docker-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }
 
        stage('Build & Push Docker Image') {
            steps {
                sh './build.sh'
            }
        }
 
        stage('Tag & Push Docker Image') {
            steps {
                sh '''
                    scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/jenkins.pem deploy.sh ubuntu@ip-172-31-9-206:/home/ubuntu/
                    ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/jenkins.pem ubuntu@ip-172-31-9-206 "chmod +x deploy.sh && BRANCH_NAME=${BRANCH_NAME} bash deploy.sh"
                '''
            }
        }
 
        stage('Deploy') {
            steps {
                echo "Trigger deployment based on branch: ${env.BRANCH_NAME}"
            }
        }
    }
}
 
 