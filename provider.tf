terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  cloud {
    organization = "royal-reddy"

    workspaces {
      name = "testing"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


