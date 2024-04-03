variable "region" {
  type        = string
  default     = "us-east-1"
  description = "region variable"
}
variable "bucket_name"{
  type        = string
  default     = "terraform_with_gitops_pri_deploy_s3_frontend_v1.0.0"
  description = "bucket name for gitops"
}
