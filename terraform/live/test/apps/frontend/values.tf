locals {
  shared = yamldecode(file("../../../../config/shared.yml"))
  env    = yamldecode(file("../../../../config/test.yml"))
}