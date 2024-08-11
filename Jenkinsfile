pipeline {
    agent any
    environment{
        AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        AWS_DEFAULT_REGION = "us-east-1"
    }

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
                }
            }
        }
        stage('terraform plan for eks-cluster'){
            steps{
                script {
                    sh "cd eks-tfconf && terraform fmt"
                    sh "cd eks-tfconf && terraform validate"
                    sh "cd eks-tfconf && terraform plan"
                }
            }
        }

    }
}