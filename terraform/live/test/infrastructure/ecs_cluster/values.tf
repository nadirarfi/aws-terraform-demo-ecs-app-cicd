locals {
  env    = yamldecode(file("../../../../config/test.yml"))
  shared = yamldecode(file("../../../../config/shared.yml"))
}