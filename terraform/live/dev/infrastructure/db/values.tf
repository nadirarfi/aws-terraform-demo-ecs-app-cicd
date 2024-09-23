locals {
  shared = yamldecode(file("../../../../config/shared.yml"))
  env    = yamldecode(file("../../../../config/dev.yml"))
}