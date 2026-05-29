# variables.tf
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
  default = "sai-portfolio-cloudfront-gitaction"
}

variable "cloudfront_distribution_name" {
  description = "CloudFront Distribution Name"
  type        = string
  default = "sai-cloud-front"
}

# If used gitub repo use this line
variable "github_repo_url" {
  description = "GitHub Repository URL"
  type        = string
  default     = "https://github.com/Saibaba-22/Whitebg-Portfolio-with-details.git"
}
