pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "maven_webapp:latest"
        TOMCAT_CONTAINER = "my-tomcat"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/trunk']], // your repo branch
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [],
                    userRemoteConfigs: [[
                        url: 'https://github.com/Spacenix69/mvn_project.git',
                        credentialsId: 'github-pat'
                    ]]
                ])
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Docker Build & Run') {
            steps {
                script {
                    // Build Docker image
                    bat "docker build -t %DOCKER_IMAGE% ."

                    // Stop and remove old container if exists
                    bat "docker rm -f %TOMCAT_CONTAINER% || echo Container not found"

                    // Run new container
                    bat "docker run -d --name %TOMCAT_CONTAINER% -p 8090:8090 %DOCKER_IMAGE%"
                }
            }
        }
    }

    post {
        success {
            echo "Deployment Successful! Visit http://localhost:8090"
        }
        failure {
            echo "Something went wrong!"
        }
    }
}

