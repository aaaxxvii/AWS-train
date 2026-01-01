terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
  
  # リソースに共通のタグをつける（管理しやすくするため）
  default_tags {
    tags = {
      Project = "gemini-terraform-training"
      ManagedBy = "Terraform"
    }
  }
}