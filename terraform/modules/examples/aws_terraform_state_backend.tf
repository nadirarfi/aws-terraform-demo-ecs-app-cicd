# ========== "aws_terraform_state_backend" ==========
module "aws_terraform_state_backend" {
  source = "../../../../../modules/aws/terraform_state_backend"

  tf_state_dynamodb_table_name = ""
  tf_state_s3_bucket_name = ""
  tags = {}
}
