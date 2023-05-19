output "regional_domain_name" {
  value = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}

output "origin_id" {
  value = "${aws_s3_bucket.s3_bucket.id}-origin"
}