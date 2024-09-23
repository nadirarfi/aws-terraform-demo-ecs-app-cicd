####################################################################################################
############## Deploy all resources
####################################################################################################

cd terraform

################################################# Infrastructure
# ./tf.sh apply-auto-approve dev vpc
# ./tf.sh apply-auto-approve dev security_groups
# ./tf.sh apply-auto-approve dev alb_target_groups
# ./tf.sh apply-auto-approve dev alb
# ./tf.sh apply-auto-approve dev ecs_cluster
# ./tf.sh apply-auto-approve dev db

# ./tf.sh apply-auto-approve prod vpc
# ./tf.sh apply-auto-approve prod security_groups
# ./tf.sh apply-auto-approve prod alb_target_groups
# ./tf.sh apply-auto-approve prod alb
# ./tf.sh apply-auto-approve prod ecs_cluster
# ./tf.sh apply-auto-approve prod db

# ################################################## Applications
# ./tf.sh apply-auto-approve dev backend
# ./tf.sh apply-auto-approve dev frontend

# ./tf.sh apply-auto-approve prod backend
# ./tf.sh apply-auto-approve prod frontend

# ################################################## CICD
./tf.sh apply-auto-approve shared codebuild
# ./tf.sh apply-auto-approve shared codedeploy
./tf.sh apply-auto-approve shared codepipeline