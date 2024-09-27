from diagrams import Cluster, Diagram
from diagrams.onprem.vcs import Github
from diagrams.aws.devtools import Codebuild, Codedeploy, Codepipeline
from diagrams.aws.storage import S3
from diagrams.aws.compute import EC2ContainerRegistry, ElasticContainerService
from diagrams.aws.network import CloudFront
from diagrams.aws.integration import SimpleNotificationServiceSnsTopic


# Set graph attributes to create more space between arrows and nodes
graph_attr = {
    "splines": "splines",
    "center": "true",
    "nodesep": "1.5",  # Increase space between nodes
    "ranksep": "1.0",  # Increase space between ranks
    "fontsize": "20",
    "size": "200,200",  # Set the maximum width and height of the diagram
    "dpi": "300"  # Set DPI (lower values result in smaller images)
}

diagram_title = "AWS CI/CD Pipeline"
codepipeline_title = "CodePipeline"

with Diagram(diagram_title, direction="LR", graph_attr=graph_attr, outformat="jpg", show=False):
    with Cluster("CI/CD Pipeline (Big Stack)", graph_attr=graph_attr):

        # CodePipeline 
        pipeline = Codepipeline("CodePipeline")
        github_repo = Github("Source\ncode repository")
        artifacts_bucket = S3("S3 Artifacts")
        backend_ecr_repoistory = EC2ContainerRegistry("ECR Repository") # ECR for Docker images
        frontend_bucket = S3("Website\nstatic files") # Frontend bucket
        frontend_cloudfront = CloudFront("CloudFront Distribution\nFrontend")
        manual_approval = SimpleNotificationServiceSnsTopic("Manual approval")

        # CodeBuild Projects for Backend and Frontend
        with Cluster("Build stage", graph_attr=graph_attr):
            build_backend = Codebuild("Codebuild\nbackend")
            build_frontend = Codebuild("Codebuild\nfrontend")
            codebuilds = [
                build_backend, build_frontend
            ]

        # Test Deploy Stage
        with Cluster("Test", graph_attr=graph_attr):
            codedeploy_test = Codedeploy("Codedeploy\ntest")
            blue_test_ecs_backend = ElasticContainerService("Blue\nECS tasks")
            green_test_ecs_backend = ElasticContainerService("Green\nECS tasks")

        # Prod Deploy Stage
        with Cluster("Prod", graph_attr=graph_attr):
            codedeploy_prod = Codedeploy("Codedeploy\nprod")
            blue_prod_ecs_backend = ElasticContainerService("Blue\nECS tasks")
            green_prod_ecs_backend = ElasticContainerService("Green\nECS tasks")

        # Define the connections with more spacing between arrows
        # github_repo >> pipeline >> build_backend >> backend_ecr_repoistory  >> codedeploy_test
        # pipeline >> build_frontend >> frontend_bucket >> frontend_cloudfront
        github_repo >> pipeline >> codebuilds >> artifacts_bucket
        build_frontend >> frontend_bucket >> frontend_cloudfront
        build_backend >> backend_ecr_repoistory  >> [codedeploy_test, codedeploy_prod]
        artifacts_bucket >> [codedeploy_test, codedeploy_prod]
        # [build_backend,build_frontend] >> artifacts_bucket >> codedeploy_test
        # backend_ecr_repoistory >> codedeploy_test
        codedeploy_test >> [green_test_ecs_backend, blue_test_ecs_backend]
        green_test_ecs_backend >> manual_approval >> codedeploy_prod >> [green_prod_ecs_backend, blue_prod_ecs_backend]

