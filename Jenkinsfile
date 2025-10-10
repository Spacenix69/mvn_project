pipeline {
    agent any
    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/Spacenix69/maven-webapp.git'
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build & Run') {
            steps {
                sh '''
                docker stop mvn_webapp || true
                docker rm mvn_webapp || true
                docker build -t mvn_webapp:latest .
                docker run -d --name mvn_webapp -p 8080:8080 jspapp:latest
                '''
            }
        }
    }
}

