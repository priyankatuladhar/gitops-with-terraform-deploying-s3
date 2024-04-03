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
  backend "local" {

    path = "./statefile.tfstate"


  }
}

resource "aws_s3_bucket" "prii_bucket" {
  bucket = var.bucket_name

  tags = merge(default_tags, {
    Name = "My bucket Priyanka"
  })
}

//not enabled versioning because deletion takes confusion

resource "aws_s3_bucket_object_lock_configuration" "tf_backend_bucket_object_lock" {
  depends_on          = [aws_s3_bucket.prii_bucket]
  bucket              = aws_s3_bucket.prii_bucket.id
  object_lock_enabled = "Enabled"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_backend_bucket_sse" {
  bucket = aws_s3_bucket.tf_backend_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_dynamodb_table" "tf_backend_bucket_state_lock" {
  name           = "terraform_state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB Terraform State Lock Table"
  }
}
