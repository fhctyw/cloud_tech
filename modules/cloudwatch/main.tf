module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage
}

resource "aws_sns_topic" "sns_topic" {
  name = "${module.label.id}-error-notifications"
}


resource "aws_lambda_function" "error_processing" {
  depends_on    = [aws_sns_topic.sns_topic]
  function_name = var.function_name
  handler       = "${var.function_name}.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.9"
  filename      = "${path.module}/src/${var.function_name}.zip"
  environment {
    variables = {
      snsARN = aws_sns_topic.sns_topic.arn
    }
  }
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  # endpoint  = aws_lambda_function.error_processing.arn
  endpoint = var.email
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


resource "aws_iam_role" "lambda_role" {
  name               = "${module.label.id}-${var.function_name}-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_exec_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "error_parse_lambda_policy" {
  name   = "${module.label.id}-${var.function_name}"
  policy = data.aws_iam_policy_document.lambda_policy.json
}

data "archive_file" "function_name" {
  type        = "zip"
  source_file = "${var.lambda_function_path}/${var.function_name}.py"
  output_path = "${path.module}/src/${var.function_name}.zip"
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sns:Publish",
    ]

    resources = [
      "arn:aws:sns:eu-central-1:717474516480:${aws_sns_topic.sns_topic.name}"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "lambda_sns_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.error_parse_lambda_policy.arn
}

resource "aws_lambda_permission" "cloudwatch_permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.error_processing.arn
  principal     = "logs.eu-central-1.amazonaws.com"
  source_arn    = "arn:aws:logs:eu-central-1:717474516480:log-group:*:*"
}

# resource "aws_cloudwatch_metric_alarm" "count_call_lambda" {
#   alarm_name          = "${module.label.id}-count-call-lambdas"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = 1
#   threshold           = 5
#   alarm_actions       = [aws_sns_topic.sns_topic.arn]
#   metric_name         = "Invocations"
#   namespace           = "AWS/Lambda"
#   period              = 30
#   statistic           = "SampleCount"
# }