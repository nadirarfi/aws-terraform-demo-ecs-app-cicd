resource "aws_dynamodb_table" "this" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.dynamodb_table_hash_key
  range_key    = var.dynamodb_table_range_key

  dynamic "attribute" {
    for_each = var.dynamodb_table_attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

}