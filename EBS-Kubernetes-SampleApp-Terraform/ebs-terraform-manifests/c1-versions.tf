# Terraform Settings Block
terraform {
  required_version = ">= 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.21.0"
    }
  helm = {
      source = "hashicorp/helm"
      #version = "2.4.1"
      version = "~> 2.4"
    }
    http = {
      source = "hashicorp/http"
      #version = "2.1.0"
      version = "~> 2.1"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-pandiyan"
    key    = "dev/ebs-storage/terraform.tfstate"
    region = "us-east-1" 

    # For State Locking
    dynamodb_table = "dev-ebs-storage"    
  }     
}

# Terraform AWS Provider Block
provider "aws" {
  region = var.aws_region
}

# Terraform HTTP Provider Block
provider "http" {
  # Configuration options
}