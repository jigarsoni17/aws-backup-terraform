# data "terraform_remote_state" "aws_backup" {
#   backend = "s3"
#   config = {
#     bucket  = "centrae-tf-backend"
#     key     = "aws_backup/terraform.tfstate"
#     region  = "us-west-2"
#     profile = "signiance-centrae"
#   }
# }
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.4.0"
    }
  }
  backend "s3" {
    key               = "aws_backup/terraform.tfstate"
    bucket            = "centrae-tf-backend"
    encrypt           = true
    profile           = "signiance-centrae"
    region            = "us-west-2"
    dynamodb_endpoint = "dynamodb.us-west-2.amazonaws.com"
    dynamodb_table    = "centrae-tf-state"

  }

}
