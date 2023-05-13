terraform {
  backend "s3" {
    bucket         = "dev-lab-website"
    key            = "./terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-tfstate-lock"
  }
}