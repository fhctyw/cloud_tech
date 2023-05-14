module "course" {
  source = "./modules/dynamodb"

  table_name = "course"
  name       = var.name
  namespace  = var.namespace
  stage      = var.stage
}

module "author" {
  source = "./modules/dynamodb"

  table_name = "author"
  name       = var.name
  namespace  = var.namespace
  stage      = var.stage
}

module "lambda_functions" {
  source = "./modules/lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_names       = var.function_names
  handler              = var.handler
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path
}

terraform {
  backend "s3" {
    bucket         = "717474516480-terraform-tfstate"
    key            = "./terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-tfstate-lock"
  }
}

provider "aws" {
  region = "eu-central-1"
}
