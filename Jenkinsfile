pipeline {
    agent any

    environment {

    }

    stages {
        stage('Checkout SCM') {
            steps{
            script {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/katoch1234/terraform-jenkins-eks.git']])
            }
            }
        }

        stage('')
    }
}