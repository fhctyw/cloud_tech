variable "stage" {
  type = string
}

variable "namespace" {
  type = string
}

variable "name" {
  type = string
}

variable "runtime" {
  description = "Runtime for Lambda function"
  type        = string
}

variable "lambda_function_path" {
  description = "Path to the ZIP files containing the function code"
  type        = string
}

variable "email" {
  description = "Email for notifications"
  type = string
}