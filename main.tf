module "course" {
  source = "./modules/dynamodb"

  table_name = "course"
}

module "author" {
  source = "./modules/dynamodb"

  table_name = "author"
}
