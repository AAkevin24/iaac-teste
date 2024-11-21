terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.76.0"
    }
     local = {
      source = "hashicorp/local"
      version = "2.5.2"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}