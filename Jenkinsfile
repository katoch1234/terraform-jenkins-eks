pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
            steps{
            script {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/katoch1234/terraform-jenkins-eks.git']])
                sh "ls -lhtra"           
            }
            }
        }

        stage('terraform init for eks-cluster'){
            steps{
                script {
                    sh "cd eks-tfconf && terraform init"
                    sh "echo 'sep 2 done'"
                }
            }
        }
    }
}