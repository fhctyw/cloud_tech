variable "table_name" {
  type = string
}

variable "stage" {
  type    = string
  default = "dev"
}

variable "namespace" {
  type    = string
  default = "lab"
}

variable "name" {
  type    = string
  default = "dynamodb-website"
}