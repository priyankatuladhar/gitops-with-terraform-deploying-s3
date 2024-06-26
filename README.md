﻿# gitops-with-terraform-deploying-s3


- Wrote Terraform code that can deploy your frontend application to S3. Use GitHub Actions Workflow to automate the full CI/CD process. It should automatically:

    - Bump artifact version based on conventional commits
    - Create Git tags, artifacts, and GitHub Releases when merged to the main branch.
    - Perform dry run (Terraform plan) when a PR is opened or synchronized.
    - Don't expose your AWS credentials anywhere, make sure to use *GitHub Actions Secret*!

References:

- https://developer.hashicorp.com/terraform/language/settings/backends/configuration
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block
- https://developer.hashicorp.com/terraform/tutorials/automation/github-actions
