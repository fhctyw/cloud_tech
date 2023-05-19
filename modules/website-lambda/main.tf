# get all authors
data "aws_iam_policy_document" "get_all_authors_policy" {
  statement {
    actions   = ["dynamodb:Scan"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/authors"]
  }
}

module "lambda_function_get_all_authors" {
  source = "../lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "get-all-authors"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.get_all_authors_policy.json
  api_gateway_rest_arn = var.api_gateway_execution_arn
  error_parse_lambda_arn = var.error_parse_lambda_arn
}

# get all courses
data "aws_iam_policy_document" "get_all_courses_policy" {
  statement {
    actions   = ["dynamodb:Scan"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/courses"]
  }
}

module "lambda_function_get_all_courses" {
  source = "../lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "get-all-courses"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.get_all_courses_policy.json
  api_gateway_rest_arn = var.api_gateway_execution_arn
  error_parse_lambda_arn = var.error_parse_lambda_arn
}

# get course
data "aws_iam_policy_document" "get_course_policy" {
  statement {
    actions   = ["dynamodb:GetItem"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/courses"]
  }
}

module "lambda_function_get_course" {
  source = "../lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "get-course"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.get_course_policy.json
  api_gateway_rest_arn = var.api_gateway_execution_arn
  error_parse_lambda_arn = var.error_parse_lambda_arn
}

# save course
data "aws_iam_policy_document" "save_course_policy" {
  statement {
    actions   = ["dynamodb:PutItem"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/courses"]
  }
}

module "lambda_function_save_course" {
  source = "../lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "save-course"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.save_course_policy.json
  api_gateway_rest_arn = var.api_gateway_execution_arn
  error_parse_lambda_arn = var.error_parse_lambda_arn
}

# update course
data "aws_iam_policy_document" "update_course_policy" {
  statement {
    actions   = ["dynamodb:PutItem"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/courses"]
  }
}

module "lambda_function_update_course" {
  source = "../lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "update-course"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.update_course_policy.json
  api_gateway_rest_arn = var.api_gateway_execution_arn
  error_parse_lambda_arn = var.error_parse_lambda_arn
}

# delete course
data "aws_iam_policy_document" "delete_course_policy" {
  statement {
    actions   = ["dynamodb:DeleteItem"]
    resources = ["arn:aws:dynamodb:eu-central-1:717474516480:table/courses"]
  }
}

module "lambda_function_delete_course" {
  source = "../lambda"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  function_name        = "delete-course"
  runtime              = var.runtime
  lambda_function_path = var.lambda_function_path

  custom_policy        = data.aws_iam_policy_document.delete_course_policy.json
  api_gateway_rest_arn = var.api_gateway_execution_arn
  error_parse_lambda_arn = var.error_parse_lambda_arn
}