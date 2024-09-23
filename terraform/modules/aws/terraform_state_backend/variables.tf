variable "tf_state_dynamodb_table_name" {
  type = string
}

variable "tf_state_s3_bucket_name" {
  type = string
}

variable "tags" {
  description = "A map of additional tags to add to all resources."
  type        = map(string)
  default     = {}
}