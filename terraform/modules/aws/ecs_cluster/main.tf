# ========== ECS Cluster ==========
resource "aws_ecs_cluster" "this" {
  name = var.ecs_cluster_name
  tags = merge(local.default_tags, var.tags)
}

# ========== SSM Parameters ==========
resource "aws_ssm_parameter" "ecs_cluster_arn" {
  type  = "String"
  name  = var.ssm_ecs_cluster_arn_key
  value = aws_ecs_cluster.this.arn
  overwrite   = true
}

resource "aws_ssm_parameter" "ecs_cluster_id" {
  type  = "String"
  overwrite   = true
  name  = var.ssm_ecs_cluster_id_key
  value = aws_ecs_cluster.this.id
}