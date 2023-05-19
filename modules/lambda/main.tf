module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "custom_lambda_policy" {
  source_policy_documents = [var.custom_policy]
}

resource "aws_iam_role" "lambda_role" {
  name               = "${module.label.id}-${var.function_name}-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_exec_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "custom_lambda_policy" {
  name   = "${module.label.id}-${var.function_name}-custom"
  policy = data.aws_iam_policy_document.custom_lambda_policy.json
}

resource "aws_iam_policy_attachment" "custom_lambda_policy_attachment" {
  name       = "${module.label.id}-custom-policy-attachment"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = aws_iam_policy.custom_lambda_policy.arn
}

resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  handler       = "${var.function_name}.handler"
  role          = aws_iam_role.lambda_role.arn
  runtime       = var.runtime
  filename      = "${path.module}/src/${var.function_name}.zip"
  environment {
    variables = var.env_vars
  }
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${var.api_gateway_rest_arn}/*/*"
}

data "archive_file" "function_name" {
  type        = "zip"
  source_file = "${var.lambda_function_path}/${var.function_name}.js"
  output_path = "${path.module}/src/${var.function_name}.zip"
}

locals {
  log_group_name = "/aws/lambda/${var.function_name}"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = local.log_group_name
}

resource "aws_cloudwatch_log_subscription_filter" "error_parsing_log" {
  depends_on = [ aws_cloudwatch_log_group.log_group ]
  name = "${module.label.id}-log"
  log_group_name = local.log_group_name
  filter_pattern = "?ERROR ?WARN ?5xx"
  # filter_pattern = " "
  destination_arn = var.error_parse_lambda_arn
}