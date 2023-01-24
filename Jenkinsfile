pipeline {
    agent none

    environment {
        DOTNET_CLI_HOME = '/tmp/dotnet_cli_home'
        XDG_DATA_HOME = '/tmp'
    }

    stages {
        stage('Build and test C#') {
            agent {
                docker { image 'dotnet/sdk:6.0-alpine' }
            }
            steps {
                sh 'dotnet build'
                sh 'dotnet test'
            }
        }

        stage('Build and test TypeScript') {
            agent {
                docker { image 'node:17-bullseye' }
            }
            dir("DotnetTemplate.Web") {
                steps {
                    sh 'npm install'
                    sh 'npm run build'
                    sh 'npm t'
                    sh 'npm run lint'
                }
            }
        }
    }
}