pipeline {
    agent any
    
    stages {
        stage('Build Image') {
            steps {
                sh 'docker build -t haritechhub/dev:latest .'
            }
        }
        
        stage('Push to Dev DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                )]) {
                    sh '''
                    echo $PASSWORD | docker login -u $USERNAME --password-stdin
                    docker push haritechhub/dev:latest
                    '''
                }
            }
        }

        stage('Push to Prod DockerHub') {
            when {
                environment name: 'GIT_BRANCH', value: 'origin/main'
            }
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                )]) {
                    sh '''
                    echo $PASSWORD | docker login -u $USERNAME --password-stdin
                    docker tag haritechhub/dev:latest haritechhub/prod:latest
                    docker push haritechhub/prod:latest
                    '''
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'docker compose down'
                sh 'docker compose up -d'
            }
        }
    }
}