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
  name = "${module.label.id}-api-gateway"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# get all authors
data "aws_iam_policy_document" "get_all_authors_policy" {
  statement {
    actions   = ["dynamodb:Scan"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/authors"]
  }
}

module "lambda_function_get_all_authors" {
  source = "./modules/lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "get-all-authors"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.get_all_authors_policy.json
  api_gateway_rest_arn = aws_api_gateway_rest_api.api_gateway.execution_arn
}

# get all courses
data "aws_iam_policy_document" "get_all_courses_policy" {
  statement {
    actions   = ["dynamodb:Scan"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/courses"]
  }
}

module "lambda_function_get_all_courses" {
  source = "./modules/lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "get-all-courses"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.get_all_courses_policy.json
  api_gateway_rest_arn = aws_api_gateway_rest_api.api_gateway.execution_arn
}

# get course
data "aws_iam_policy_document" "get_course_policy" {
  statement {
    actions   = ["dynamodb:GetItem"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/courses"]
  }
}

module "lambda_function_get_course" {
  source = "./modules/lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "get-course"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.get_course_policy.json
  api_gateway_rest_arn = aws_api_gateway_rest_api.api_gateway.execution_arn
}

# save course
data "aws_iam_policy_document" "save_course_policy" {
  statement {
    actions   = ["dynamodb:PutItem"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/courses"]
  }
}

module "lambda_function_save_course" {
  source = "./modules/lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "save-course"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.save_course_policy.json
  api_gateway_rest_arn = aws_api_gateway_rest_api.api_gateway.execution_arn
}

# update course
data "aws_iam_policy_document" "update_course_policy" {
  statement {
    actions   = ["dynamodb:PutItem"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/courses"]
  }
}

module "lambda_function_update_course" {
  source = "./modules/lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "update-course"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.update_course_policy.json
  api_gateway_rest_arn = aws_api_gateway_rest_api.api_gateway.execution_arn
}

# delete course
data "aws_iam_policy_document" "delete_course_policy" {
  statement {
    actions   = ["dynamodb:DeleteItem"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/courses"]
  }
}

module "lambda_function_delete_course" {
  source = "./modules/lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "delete-course"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.delete_course_policy.json
  api_gateway_rest_arn = aws_api_gateway_rest_api.api_gateway.execution_arn
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
