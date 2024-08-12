# EKS and Jenkins Server Terraform Configurations

This repository contains Terraform configurations and a Jenkins pipeline for setting up an EKS cluster and Jenkins servers on AWS, building Docker images, and deploying them using Kubernetes.

## Repository Structure

- **eks-tfconf/**  
  Contains Terraform files that are used to create an Amazon EKS cluster on AWS.

- **jenkins-server-tfconf/**  
  Contains Terraform files that are used to create Jenkins servers on AWS.

- **Dockerfile**  
  Defines the Docker image that will be built and pushed to Amazon ECR as part of the CI/CD pipeline.

- **Jenkinsfile**  
  The Jenkins pipeline script that orchestrates the following tasks:
  1. Creates the EKS cluster using the Terraform configurations in `eks-tfconf/`.
  2. Builds a Docker image using the `Dockerfile` and pushes it to Amazon ECR.
  3. Triggers a downstream pipeline in a separate GitHub repository (`kubernetes-manifests`), passing the `BUILD_NUMBER` as a parameter.

## CI/CD Pipeline Workflow

1. **EKS Cluster Creation**  
   The Jenkins pipeline initializes and applies the Terraform configurations in `eks-tfconf/` to create an EKS cluster on AWS.

2. **Docker Image Build and Push**  
   The pipeline builds a Docker image using the `Dockerfile` located in the root directory. After building, the image is tagged and pushed to Amazon ECR.

3. **Triggering Child Pipeline**  
   Once the Docker image is pushed, the pipeline triggers a child Jenkins pipeline located in the `kubernetes-manifests` repository. The `BUILD_NUMBER` from the current build is passed as a parameter.

4. **Updating Deployment YAML**  
   The child pipeline in the `kubernetes-manifests` repository updates the Docker image in the `deployment.yaml` file with the newly built image, ensuring that the Kubernetes deployment is using the latest version of the application.

## Prerequisites

- AWS account with necessary IAM permissions.
- Jenkins server with access to the AWS CLI and Terraform.
- Access to the `kubernetes-manifests` repository for triggering the child pipeline.

## How to Use

1. Clone this repository and navigate to the desired directory (`eks-tfconf/` or `jenkins-server-tfconf/`) to customize the Terraform configurations if needed.
2. Set up your Jenkins server using the Terraform files in `jenkins-server-tfconf/`.
3. Configure your Jenkins job to use the `Jenkinsfile` in this repository.
4. Run the Jenkins pipeline to set up the EKS cluster, build and push the Docker image, and trigger the child pipeline to update the Kubernetes deployment.

## Additional Information

- Ensure that the necessary AWS credentials and environment variables are set up on your Jenkins server.
- The `kubernetes-manifests` repository should contain the `deployment.yaml` file with a placeholder for the Docker image tag that will be updated by the child pipeline.