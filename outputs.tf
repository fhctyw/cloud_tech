output "bucket_name" {
  value       = aws_s3_bucket.website_bucket.id
  description = "bucket id/name"
}

output "bucket_region" {
  value       = aws_s3_bucket.website_bucket.region
  description = "bucket region"
}

output "bucket_version" {
  value       = aws_s3_bucket_versioning.website_bucket.versioning_configuration
  description = "bucket version configuration"
}