resource "aws_iam_role" "lambda_role" {
  name = "${module.label.id}-lambda-role"

  assume_role_policy = file("${path.module}/trust-policy.json")
}

resource "aws_lambda_function" "lambda_function" {
  for_each = toset(var.function_names)

  function_name = each.key
  handler       = var.handler
  role          = aws_iam_role.lambda_role.arn
  runtime       = var.runtime
  filename      = "${var.lambda_function_path}/${each.key}.zip"

  environment {
    variables = var.env_vars
  }
}

data "archive_file" "function_name" {
  for_each = toset(var.function_names)
  type        = "zip"
  source_file = "${var.lambda_function_path}/${each.key}.js"
  output_path = "${var.lambda_function_path}/${each.key}.zip"
}

module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage
}