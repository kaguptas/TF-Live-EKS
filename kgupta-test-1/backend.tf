terraform {
  backend "s3" {
    region = "us-west-2"
    bucket = "cloudops-artifacts"
    key    = "terraform/eks/gitops/kgupta-test-1/terraform.tfstate"
  }
  required_version = "1.3.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.36.1"
    }
    kubernetes = {
      version = "2.14.0"
    }
    helm = {
      version = "2.7.1"
    }
    random = {
      version = "~> 3.4"
    }
    local = {
      version = "~> 2.2"
    }
    null = {
      version = "~> 3.2"
    }
  }
}
