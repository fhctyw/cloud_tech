module "course" {
  source = "./modules/dynamodb"

  table_name = "courses"
  name       = var.name
  namespace  = var.namespace
  stage      = var.stage
}

module "author" {
  source = "./modules/dynamodb"

  table_name = "authors"
  name       = var.name
  namespace  = var.namespace
  stage      = var.stage
}

resource "aws_api_gateway_rest_api" "api_gateway" {
  name = "${var.namespace}-${var.stage}-${var.name}-api-gateway"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

module "website_lambda" {
  depends_on = [ aws_api_gateway_rest_api.api_gateway ]
  source = "./modules/website-lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  runtime = var.runtime
  lambda_function_path = var.lambda_function_path

  api_gateway_execution_arn = aws_api_gateway_rest_api.api_gateway.execution_arn
}

locals {
  absolute_website_path = "/home/arsen/react-app-frontend"
  function_invoke_arns = module.website_lambda.function_invoke_arns
}

module "api" {
  depends_on = [ module.website_lambda ]
  source = "./modules/api_gateway"

  api_gateway_id        = aws_api_gateway_rest_api.api_gateway.id
  api_gateway_parent_id = aws_api_gateway_rest_api.api_gateway.root_resource_id
  absolute_website_path = local.absolute_website_path
  function_lambda_arns  = local.function_invoke_arns
}

module "s3_bucket" {
  depends_on = [ module.api ]
  source = "./modules/s3"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  s3_name               = "authors-courses"
  absolute_website_path = local.absolute_website_path
}

module "cloudfront_s3" {
  depends_on = [ module.api ]
  source = "./modules/cloudfront"

  regional_domain_name = module.s3_bucket.regional_domain_name
  origin_id            = module.s3_bucket.origin_id
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
