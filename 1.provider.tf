terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.0"
}

# use this backend block if you need normal terraform 
# mandatory when use with cicd tools like githubactions, azure devops or jenkins
terraform {
  backend "s3" {
    bucket         = "saiterrastate"   # S3 bucket name
    key            = "terraform.tfstate"   # path inside bucket
    region         = "ap-south-1"
//    dynamodb_table = "terraform-lock-table"        # for state locking
    encrypt        = true
  }
}
