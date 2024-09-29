from diagrams import Cluster, Diagram, Edge
from diagrams.aws.network import CloudFront, ALB, VPC, PrivateSubnet, PublicSubnet, Route53
from diagrams.aws.storage import S3
from diagrams.aws.compute import ElasticContainerService
from diagrams.aws.security import ACM
from diagrams.onprem.iac import Terraform
from diagrams.onprem.client import Users, User
from diagrams.aws.database import Dynamodb





# Set graph attributes for better spacing
graph_attr = {
    "splines": "splines",
    "center": "true",
    "nodesep": "1.5",  # Increase space between nodes
    "ranksep": "1.5",  # Increase space between ranks
    "fontsize": "20",
    "size": "500,500",  # Set the maximum width and height of the diagram
    "dpi": "300"  # Set DPI (lower values result in smaller images)
}
# Diagram title
diagram_title = "AWS Infrastructure Architecture"

with Diagram(diagram_title, direction="RL", filename="infrastructure", graph_attr=graph_attr, outformat="jpg", show=False):
    cloud_engineer = User("Cloud Engineer")
    users = Users("End users")
    iac = Terraform("Infrastructure As Code")

    # CloudFront as part of the AWS Global Network
    with Cluster("AWS Global Network",graph_attr=graph_attr, ):
        cloudfront = CloudFront("CloudFront\nDistribution (CDN)")
        frontend_s3 = S3("S3 bucket\n(frontend static files)")

        with Cluster("Terraform state \nremote backend",graph_attr=graph_attr):
            s3_tf_state = S3("S3 Backend")
            dynamodb_tf_state = Dynamodb("DynamoDB table\nlocks")
            terraform_state = [s3_tf_state, dynamodb_tf_state]

        route53 = Route53("Route 53\nHosted Zone\nnadirarfi.com")
        acm = ACM("AWS Certificate\nManager")
        dns = [route53, acm]

        with Cluster("AWS Region",graph_attr=graph_attr, ):
            dynamodb_table = Dynamodb("DynamoDB"
                                      )
            # VPC setup for ALB and ECS Cluster
            with Cluster("VPC",graph_attr=graph_attr, ):
                with Cluster("Public Subnet",graph_attr=graph_attr, ):
                    alb = ALB("Application\nLoad Balancer")

                with Cluster("Private Subnet",graph_attr=graph_attr, ):
                    # ECS Cluster with ECS Service and Tasks in private subnet
                    with Cluster("ECS Cluster",graph_attr=graph_attr, ):
                        ecs_service = ElasticContainerService("Backend\nECS Service")
                        with Cluster("Auto-scaling",graph_attr=graph_attr, ):
                            ecs_task_1 = ElasticContainerService("ECS Task 1")
                            ecs_task_2 = ElasticContainerService("ECS Task 2")
                            ecs_task_3 = ElasticContainerService("ECS Task 3")
                            ecs_tasks = [ecs_task_1, ecs_task_2, ecs_task_3]

    # Connections
    route53 >> cloudfront
    
    cloudfront >> [frontend_s3, alb]  # CloudFront to origins
    alb >> ecs_service  
    ecs_service >> [ecs_task_1, ecs_task_2, ecs_task_3]
    ecs_tasks >> dynamodb_table

    users >> route53
    iac >> terraform_state

    route53 \
        - Edge(style="dashed")\
        - acm
    
    alb \
        - Edge(style="dashed")\
        - acm

    cloudfront \
        - Edge(style="dashed")\
        - acm        


    cloud_engineer >> iac 
    iac \
        - Edge(style="dashed", forward=True, reverse=False, color="purple")\
        - ecs_service      
    
    s3_tf_state \
        - Edge(style="dashed", color="purple")\
        - dynamodb_tf_state
    
