terraform {
  backend "s3" {
    profile        = "arfin-admin"
    bucket         = "app-nadir-terraform-state"
    key            = "live/dev/infrastructure/db/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "app-nadir-terraform-state"
    encrypt        = true
  }
}
