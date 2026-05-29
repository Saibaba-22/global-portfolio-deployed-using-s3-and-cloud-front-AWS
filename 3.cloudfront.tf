# CLOUDFRONT DISTRIBUTION
resource "aws_cloudfront_distribution" "cdn" {
  enabled    = true
  comment    = var.cloudfront_distribution_name
  depends_on = [aws_s3_bucket.static_site]

  # S3 WEBSITE ENDPOINT
  origin {
    domain_name = aws_s3_bucket_website_configuration.website.website_endpoint
    origin_id   = "s3-website-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"

      origin_ssl_protocols = [
        "TLSv1.2"
      ]
    }

    origin_path = ""
  }

  default_root_object = "index.html"

  # CACHE BEHAVIOR
  default_cache_behavior {
    target_origin_id       = "s3-website-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = [
      "GET",
      "HEAD"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  # CUSTOM ERROR RESPONSE
  custom_error_response {
    error_code            = 403
    response_page_path    = "/index.html"
    response_code         = 200
    error_caching_min_ttl = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = var.cloudfront_distribution_name
  }
}

# CLOUDFRONT INVALIDATION
resource "null_resource" "cloudfront_invalidation" {
  depends_on = [
    aws_cloudfront_distribution.cdn,

    # if local files are copied use this line
#    null_resource.upload_files

    # If Git Repo are used use this line 
    null_resource.upload_repo

  ]

  provisioner "local-exec" {

    interpreter = ["/bin/bash", "-c"]

    command = <<EOT
aws cloudfront create-invalidation \
  --distribution-id ${aws_cloudfront_distribution.cdn.id} \
  --paths "/*"
EOT
  }

/*
  provisioner "local-exec" {
    command     = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.cdn.id} --paths '/*'"
    interpreter = ["PowerShell", "-Command"]
  }
  */
}
