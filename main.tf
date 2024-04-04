provider "aws" {
  region = var.region

  //tags I can use anywhere in this file
  default_tags {
    tags = {
      Name      = "Priyanka Gitops assignment tags"
      Creator   = "priyankatuladharmail@gmail.com"
      Deletable = "Yes"
      Project   = "Intern"
    }
  }
}
terraform {
  backend "s3" {
    bucket         = "priyanka-terraform-gitops"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "pri-tf-lockfile"
  }
}

locals {
  bucket_name_new = "${var.bucket_name}-${terraform.workspace}"
}

# path = "./statefile.tfstate"


resource "aws_s3_bucket" "tf_backend_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "tf_backend_bucket_versioning" {
  bucket = aws_s3_bucket.tf_backend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "tf_backend_bucket_sse" {
  bucket = aws_s3_bucket.tf_backend_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}
