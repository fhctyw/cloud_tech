variable "name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "stage" {
  type = string
}

variable "function_name" {
  description = "Names of the Lambda functions"
  type        = string
}

variable "runtime" {
  description = "Runtime for Lambda function"
  type        = string
}

variable "lambda_function_path" {
  description = "Path to the ZIP files containing the function code"
  type        = string
}

variable "custom_policy" {
  description = "Custom policy for Lambda function"
}

variable "env_vars" {
  description = "Environment variables for Lambda function"
  type        = map(string)
  default     = {}
}

variable "api_gateway_rest_arn" {
  description = "Execution arn of rest api"
}