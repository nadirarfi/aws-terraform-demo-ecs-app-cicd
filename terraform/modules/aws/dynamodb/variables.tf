variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "dynamodb_table_hash_key" {
  description = "The attribute to use as the hash (partition) key for the table"
  type        = string
}

variable "dynamodb_table_range_key" {
  description = "The attribute to use as the range (sort) key for the table (optional)"
  type        = string
  default     = null
}

variable "dynamodb_table_attributes" {
  description = "A map of attributes to be used in the DynamoDB table. Each attribute should have a name and type."
  type = list(object({
    name = string
    type = string
  }))
  default = [
    {
      name = "id",
      type = "N",
    }
  ]  
}
