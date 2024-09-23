provider "aws" {
  region  = local.shared.aws_region_name
  profile = local.shared.aws_profile_name
}

provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = local.shared.aws_profile_name
}