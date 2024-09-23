# ========== "aws_dynamodb" ==========
module "aws_dynamodb" {
  source = "../../../../../modules/aws/dynamodb"

  dynamodb_table_name = ""
  dynamodb_table_hash_key = ""
  dynamodb_table_range_key = null
  dynamodb_table_attributes = [
}
