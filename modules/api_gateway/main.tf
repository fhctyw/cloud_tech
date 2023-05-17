module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage
}

resource "aws_api_gateway_rest_api" "api_gateway" {
  name = "${module.label.id}-api-gateway"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# data "aws_iam_policy_document" "assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["apigateway.amazonaws.com"]
#     }
#   }
# }

# data "aws_iam_policy_document" "api_gateway_logs_policy" {
#   statement {
#     actions = [
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:DescribeLogGroups",
#       "logs:DescribeLogStreams",
#       "logs:PutLogEvents",
#       "logs:GetLogEvents",
#       "logs:FilterLogEvents"
#     ]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_role_policy" "api_gateway_logs_policy" {
#   name   = "${module.label.id}-api-gateway-logs"
#   role   = aws_iam_role.api_gateway_role.id
#   policy = data.aws_iam_policy_document.api_gateway_logs_policy.json
# }

# resource "aws_iam_role" "api_gateway_role" {
#   name               = "${module.label.id}-api-gateway-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
# }
