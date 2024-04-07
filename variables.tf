variable "region" {
  type        = string
  default     = "us-east-1"
  description = "region variable"
}

variable "default_tags" {
  description = "Default tags to apply to resources"
  type        = map(string)
  default = {
    Name      = "Priyanka Gitops assignment tags"
    Creator   = "priyankatuladharmail@gmail.com"
    Deletable = "Yes"
    Project   = "Intern"
  }
}

variable "s3_dist_bucket" {
  default = "terraformwithgitopsprideploys3frontend"
}

variable "devops_interns_repo_name" {
  default = "gitops_demo_repo_priyanka"
}
