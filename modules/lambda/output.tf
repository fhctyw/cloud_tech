output "lambda_function_invoke_arn" {
  value = aws_lambda_function.lambda_function.invoke_arn
  description = "The Invoke ARN of the lambda function"
}
