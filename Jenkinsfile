pipeline {
    agent any
    
    stages {
        stage('Build Image') {
            steps {
                sh 'docker build -t haritechhub/dev:latest .'
            }
        }
        
        stage('Push to DockerHub') {
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
        
        stage('Deploy') {
            steps {
                sh 'docker-compose down'
                sh 'docker-compose up -d'
            }
        }
    }
}