variable "stage" {
  type = string
}

variable "namespace" {
  type = string
}

variable "name" {
  type = string
}

variable "function_names" {
  description = "Names of the Lambda functions"
  type        = list(string)
}

variable "handler" {
  description = "Lambda function handler"
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