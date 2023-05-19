variable "name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "stage" {
  type = string
}

variable "email" {
  description = "Email for notifications"
  type        = string
}

variable "lambda_function_path" {
  description = "Path to the ZIP files containing the function code"
  type        = string
}

variable "function_name" {
  description = "Names of the Lambda functions"
  type        = string
}