module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage
}

locals {
  s3_name = "${module.label.id}-${var.s3_name}-bucket"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = local.s3_name
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid    = "AddPerm"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]
    resources = ["arn:aws:s3:::${local.s3_name}/*"]
  }
}

resource "aws_s3_bucket_policy" "aws_s3_bucket_policy" {
  depends_on = [aws_s3_bucket_public_access_block.s3_bucket_public_access_block]
  bucket     = aws_s3_bucket.s3_bucket.id
  policy     = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_s3_object" "s3_index_object" {
  bucket       = aws_s3_bucket.s3_bucket.id
  content_type = "text/html"
  key          = "index.html"
  source       = "${var.absolute_website_path}/build/index.html"
  etag         = filemd5("${var.absolute_website_path}/build/index.html")
}

locals {
  mime_types = jsondecode(file("${path.module}/mime.json"))
}

resource "aws_s3_object" "s3_static_objects" {
  for_each = fileset("${var.absolute_website_path}/build", "**")

  bucket = aws_s3_bucket.s3_bucket.id
  key    = each.value
  source = "${var.absolute_website_path}/build/${each.value}"

  content_type = lookup("${local.mime_types}", regex("\\.[^.]+$", each.value), null)
  etag         = filemd5("${var.absolute_website_path}/build/${each.value}")
}

resource "aws_s3_bucket_website_configuration" "s3_bucket_website_configuration" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }
}