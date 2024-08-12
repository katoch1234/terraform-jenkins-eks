pipeline {
    agent any
    environment{
        AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        AWS_DEFAULT_REGION = "us-east-1"
        IMAGE_NAME = "app"
        AWS_ACCOUNT_ID = "891377015170"
        IMAGE_REPO_NAME = "vaibhav"
        IMAGE_TAG = "${BUILD_NUMBER}"
        REPOSITORY_URL = "891377015170.dkr.ecr.us-east-1.amazonaws.com/vaibhav"
        ECR_REPO_NAME = "vaibhav"
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
                    sh "cd eks-tfconf && ls -lhtra && terraform init"
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

     /*  stage('terraform apply for eks-cluster'){
            steps{
                script {
                    sh "cd eks-tfconf && terraform apply --auto-approve"
                }
            }
        } */
       
       stage('docker build'){
            steps{
                script {
                    app = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Logging to ECR'){
            steps{
                script {
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com"
                }
            }
        }

        stage('Docker Push'){
            steps{
                script{
                    sh "docker tag ${IMAGE_NAME}:latest ${REPOSITORY_URL}:${BUILD_NUMBER}"
                    sh "docker push ${REPOSITORY_URL}:${BUILD_NUMBER}"
                }
            }
        }

        stage('Trigger ManifestUpdate') {
            steps{
                echo "triggering k8 deployment image update"
                echo " NOTE: K8 MANIFEST REPO IS kubernetes-manifests"
                build job: 'kubernetes-manifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
            }
        }

    }
}