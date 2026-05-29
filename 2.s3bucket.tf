# S3 BUCKET
resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name
  tags = {   Name = var.bucket_name  }
  force_destroy = true
}

# STATIC WEBSITE HOSTING
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.static_site.id
  index_document {  suffix = "index.html"  }
}

# DISABLE BLOCK PUBLIC ACCESS
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_site.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 BUCKET POLICY
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.static_site.id
  depends_on = [  aws_s3_bucket_public_access_block.public_access  ]

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "ExampleStatementID"
        Effect = "Allow"

        Principal = "*"

        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]

        Resource = [
          "${aws_s3_bucket.static_site.arn}",
          "${aws_s3_bucket.static_site.arn}/*"
        ]
      }
    ]
  })
}


# Github actions
resource "null_resource" "clone_repo" {
  provisioner "local-exec" {
    command = <<EOT
rm -rf portfolio-repo
git clone ${var.github_repo_url} portfolio-repo
EOT

    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "upload_repo" {

  depends_on = [
    null_resource.clone_repo,
    aws_s3_bucket.static_site
  ]

  provisioner "local-exec" {

    command = <<EOT
aws s3 sync portfolio-repo s3://${aws_s3_bucket.static_site.bucket}
EOT

  }
}

}
