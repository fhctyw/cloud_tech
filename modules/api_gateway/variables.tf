variable "api_gateway_id" {
  type = string
}

variable "api_gateway_parent_id" {
  type = string
}

variable "function_lambda_arns" {
  type = map(string)
}

variable "absolute_website_path" {
  type = string
}