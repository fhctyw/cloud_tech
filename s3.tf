resource "aws_s3_bucket" "website_bucket" {
  bucket = module.label.id
}


resource "aws_s3_bucket_versioning" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}