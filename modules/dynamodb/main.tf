resource "aws_dynamodb_table" "table" {
  name         = "${module.label.id}-${var.table_name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  attribute {
    name = "id"
    type = "S"
  }
}

module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage
}
