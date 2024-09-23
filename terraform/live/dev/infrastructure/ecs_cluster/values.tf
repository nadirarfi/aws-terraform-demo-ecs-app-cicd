locals {
  env    = yamldecode(file("../../../../config/dev.yml"))
  shared = yamldecode(file("../../../../config/shared.yml"))
}