# ========== "aws_ecs_cluster" ==========
module "aws_ecs_cluster" {
  source = "../../../../../modules/aws/ecs_cluster"

  ecs_cluster_name = ""
  ssm_ecs_cluster_arn_key = ""
  ssm_ecs_cluster_id_key = ""
  tags = {}
}
