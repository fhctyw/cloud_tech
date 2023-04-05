resource "aws_iam_role" "iam_for_lambda" {
  name               = "${var.function_name}-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  filename      = "lambda_function_payload.zip"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
}