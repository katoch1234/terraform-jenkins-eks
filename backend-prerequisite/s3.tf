resource "aws_s3_bucket" "jenkins-backend6789" {
  bucket = "jenkins-backend678-kode-kloud"
  tags = {
    Name = "S3 Remote Terraform State Store"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3-buckey-encryption" {
  bucket = aws_s3_bucket.jenkins-backend6789.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}