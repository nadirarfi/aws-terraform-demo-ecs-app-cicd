provider "aws" {
  region  = local.shared.aws_region_name
  profile = local.shared.aws_profile_name
}