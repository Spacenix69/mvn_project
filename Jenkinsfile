pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "maven_webapp:latest"
        TOMCAT_CONTAINER = "my-tomcat"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Spacenix69/maven_webapp.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build & Run') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t $DOCKER_IMAGE ."

                    // Stop and remove old container if exists
                    sh "docker rm -f $TOMCAT_CONTAINER || true"

                    // Run new container
                    sh "docker run -d --name $TOMCAT_CONTAINER -p 8090:8090 $DOCKER_IMAGE"
                }
            }
        }
    }

    post {
        success {
            echo "Deployment Successful! Visit http://localhost:8080"
        }
        failure {
            echo "Something went wrong!"
        }
    }
}

