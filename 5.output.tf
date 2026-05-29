output "s3_static_website_endpoint" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.cdn.id
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "bucket_name" {
  value = aws_s3_bucket.static_site.bucket
}
