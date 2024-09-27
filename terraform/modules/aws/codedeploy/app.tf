# ------- AWS CodeDeploy App definition for each module -------
resource "aws_codedeploy_app" "this" {
  compute_platform = var.codedeploy_app_compute_platform
  name             = var.codedeploy_app_name
}