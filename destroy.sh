cd terraform

################################################## CICD
# ./tf.sh destroy-auto-approve shared codepipeline
# ./tf.sh destroy-auto-approve shared codedeploy
# ./tf.sh destroy-auto-approve shared codebuild

################################################## Applications (ECS service)
./tf.sh destroy-auto-approve dev frontend
./tf.sh destroy-auto-approve prod frontend

# ./tf.sh destroy-auto-approve dev backend
# ./tf.sh destroy-auto-approve prod backend

################################################# Infrastructure
# ./tf.sh destroy-auto-approve dev db
# ./tf.sh destroy-auto-approve prod db

# ./tf.sh destroy-auto-approve dev ecs_cluster
# ./tf.sh destroy-auto-approve prod ecs_cluster

# ./tf.sh destroy-auto-approve dev alb
# ./tf.sh destroy-auto-approve prod alb

# ./tf.sh destroy-auto-approve dev alb_target_groups
# ./tf.sh destroy-auto-approve prod alb_target_groups

# ./tf.sh destroy-auto-approve dev security_groups
# ./tf.sh destroy-auto-approve prod security_groups

# ./tf.sh destroy-auto-approve dev vpc
# ./tf.sh destroy-auto-approve prod vpc