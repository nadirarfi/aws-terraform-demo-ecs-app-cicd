
module "prod_dynamodb_table" {
  source = "../../../../modules/aws/dynamodb"

  dynamodb_table_name     = local.env.app_backend_dynamodb_table_name
  dynamodb_table_hash_key = "id"
  dynamodb_table_attributes = [
    # S for String, N for Number, B for Binary
    {
      name = "id"
      type = "S"
    }
  ]
}