locals {
  env    = yamldecode(file("../../../../config/prod.yml"))
  shared = yamldecode(file("../../../../config/shared.yml"))
}