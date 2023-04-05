module "course" {
  source = "./modules/dynamodb"

  table_name = "course"
}

module "author" {
  source = "./modules/dynamodb"

  table_name = "author"
}

module "lambda_function" {
  source = "./modules/lambda"

  function_name = module.label.id
  filename      = var.function_filename
}