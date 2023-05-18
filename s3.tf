# locals {
#   s3_name = "${module.label.id}-bucket"
# }

# data "aws_iam_policy_document" "s3_policy" {
#   statement {
#     sid = "AddPerm"
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#         "s3:GetObject"
#     ]
#     resources = ["arn:aws:s3:::${local.s3_name}/*"]
#   }
# }

# resource "aws_s3_bucket" "s3_bucket" {
#   bucket = local.s3_name
# }

# resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_blockle" {
#   bucket = aws_s3_bucket.s3_bucket.id

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

# resource "aws_s3_bucket_policy" "aws_s3_bucket_policy" {
#   bucket = aws_s3_bucket.s3_bucket.id
#   policy = data.aws_iam_policy_document.s3_policy.json
# }

# resource "aws_s3_bucket_website_configuration" "s3_bucket_website_configuration" {
#   bucket = aws_s3_bucket.s3_bucket.id

#   index_document {
#     suffix = "index.html"
#   }
# }