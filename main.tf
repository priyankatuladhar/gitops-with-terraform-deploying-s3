provider "aws" {
	region = var.region
  }
  
  terraform {
	backend "s3" {
	  bucket         = "terraformwithgitopsprideploys3frontendpriyanka1.0"
	  key            = "terraform.tfstate"
	  region         = "us-east-1"
	  dynamodb_table = "terraform_state_pri"
	}
  }
  
  resource "aws_s3_bucket" "tf_backend_bucket" {
	bucket = var.tf_backend_bucket_name
	tags = {
	  "Name" = "DynamoDB Terraform State Lock Table priyanka"
  	  "Creator"   = "priyankatuladharmail@gmail.com"
	  "Deletable" = "Yes"
	  "Project"   = "Intern"
	}
  }
  
  resource "aws_s3_bucket_versioning" "tf_backend_bucket_versioning" {
	bucket = aws_s3_bucket.tf_backend_bucket.id
	versioning_configuration {
	  status = "Enabled"
	}
  }
  
  resource "aws_s3_bucket_object_lock_configuration" "tf_backend_bucket_object_lock" {
	depends_on          = [aws_s3_bucket.tf_backend_bucket]
	bucket              = aws_s3_bucket.tf_backend_bucket.id
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
	name           = "terraform_state_pri"
	read_capacity  = 1
	write_capacity = 1
	hash_key       = "LockID"
	attribute {
	  name = "LockID"
	  type = "S"
	}
	tags = {
	  "Name" = "DynamoDB Terraform State Lock Table priyanka"
  	  "Creator"   = "priyankatuladharmail@gmail.com"
	  "Deletable" = "Yes"
	  "Project"   = "Intern"
	}
  }
  
  resource "aws_codecommit_repository" "gitops_demo_repo" {
	repository_name = var.devops_interns_repo_name
	description     = "Created for \"GitOps with Terraform\" session"
	tags = {
	  "Name" = "DynamoDB Terraform State Lock Table priyanka"
  	  "Creator"   = "priyankatuladharmail@gmail.com"
	  "Deletable" = "Yes"
	  "Project"   = "Intern"
	}
  }
  
// provider "aws" {
//   region = var.region

//   //tags I can use anywhere in this file
//   default_tags {
//     tags = {
//       Name      = "Priyanka Gitops assignment tags"
//       Creator   = "priyankatuladharmail@gmail.com"
//       Deletable = "Yes"
//       Project   = "Intern"
//     }
//   }
// }
// terraform {
//   backend "s3" {
//     bucket         = "terraformwithgitopsprideploys3frontend"
//     key            = "terraform.tfstate"
//     region         = "us-east-1"
//     dynamodb_table = "pri-tf-lockfile"
//   }
// }

// locals {
//   bucket_name_new = "${var.bucket_name}-${terraform.workspace}"
// }

// # path = "./statefile.tfstate"


// resource "aws_s3_bucket" "tf_backend_bucket" {
//   bucket = var.bucket_name
// }

// resource "aws_s3_bucket_versioning" "tf_backend_bucket_versioning" {
//   bucket = aws_s3_bucket.tf_backend_bucket.id
//   versioning_configuration {
//     status = "Enabled"
//   }
// }


// resource "aws_s3_bucket_server_side_encryption_configuration" "tf_backend_bucket_sse" {
//   bucket = aws_s3_bucket.tf_backend_bucket.id
//   rule {
//     apply_server_side_encryption_by_default {
//       sse_algorithm = "aws:kms"
//     }
//   }
// }
