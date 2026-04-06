terraform {
  backend "s3" {
    bucket         = "az-netflix-tf-state" 
    key            = "netflix-platform/prod/terraform.tfstate"
    region         = "us-east-1"                        
    dynamodb_table = "terraform-state-lock"             
    encrypt        = true
  }
}