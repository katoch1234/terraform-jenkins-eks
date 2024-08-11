terraform {
  backend "s3" {
    bucket         = "jenkins-backend678-kode-kloud"
    key            = "myapp/production/tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state"
  }
}