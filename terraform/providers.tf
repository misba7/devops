provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "Microservices-Demo"
      ManagedBy = "Terraform"
    }
  }
}