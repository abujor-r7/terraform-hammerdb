terraform {
    backend "s3" {
        bucket         = "terraform-hammerdb-state"
        key            = "hammerdb/terraform.tfstate"
        region         = "eu-central-1"
        dynamodb_table = "terraform-hammerdb-lock"
        encrypt        = true
      
    }
}
provider "aws" {
    region = var.aws_region

    allowed_account_ids = ["${var.aws_account_id}"]
}
