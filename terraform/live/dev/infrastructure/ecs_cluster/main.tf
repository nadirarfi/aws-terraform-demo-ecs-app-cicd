# ========== ECS Cluster ==========
module "dev_app_backend_ecs_cluster" {
  source                  = "../../../../modules/aws/ecs_cluster"
  ecs_cluster_name        = local.env.app_backend_ecs_cluster_name
  ssm_ecs_cluster_arn_key = local.env.ssm_params.app_backend_ecs_cluster_arn
  ssm_ecs_cluster_id_key  = local.env.ssm_params.app_backend_ecs_cluster_id
  tags                    = {}
}