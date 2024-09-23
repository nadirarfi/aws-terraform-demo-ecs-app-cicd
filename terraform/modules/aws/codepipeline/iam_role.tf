
resource "aws_iam_role" "codepipeline_service_role" {
  name = "${var.codepipeline_name}-role"
  path = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          "Service" : "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "codepipeline_service_policy" {
  name = "${var.codepipeline_name}-policy"
  description = "Policy for CodePipeline to interact with CloudWatch, S3, and CodeBuild"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "codestar-connections:*"
        ],
        Resource = "*"
      },
      {
        Sid    = "AllowCloudWatchActions"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowS3Actions"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketAcl",
          "s3:List*"
        ]
        Resource = [
          "arn:aws:s3:::*/*"
        ]
      },
      {
        Sid    = "AllowCodebuildActions"
        Effect = "Allow"
        Action = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:BatchGetBuildBatches",
          "codebuild:StartBuildBatch",
          "codebuild:StopBuild",
          "codebuild:ListBuilds",
          "codebuild:BatchGetProjects",
          "codebuild:ListBuildsForProject"
        ]
        Resource = [
          "arn:aws:codebuild:*:*:project/*"
        ]
      },
      {
        Sid    = "AllowCodeDeployActions"
        Effect = "Allow"
        Action = [
          "codedeploy:CreateDeployment",
          "codedeploy:GetApplication",
          "codedeploy:GetApplicationRevision",
          "codedeploy:GetDeployment",
          "codedeploy:GetDeploymentGroup",
          "codedeploy:RegisterApplicationRevision"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Sid    = "AllowCodeDeployConfigs"
        Effect = "Allow"
        Action = [
          "codedeploy:GetDeploymentConfig",
          "codedeploy:CreateDeploymentConfig",
          "codedeploy:CreateDeploymentGroup",
          "codedeploy:GetDeploymentTarget",
          "codedeploy:StopDeployment",
          "codedeploy:ListApplications",
          "codedeploy:ListDeploymentConfigs",
          "codedeploy:ListDeploymentGroups",
          "codedeploy:ListDeployments"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Sid    = "AllowECSActions"
        Effect = "Allow"
        Action = [
          "ecs:RegisterTaskDefinition",
          "ecs:UpdateService",
          "ecs:DescribeServices",
          "ecs:CreateService",
          "ecs:DeleteService",
          "ecs:DescribeTaskDefinition",
          "ecs:DescribeTasks",
          "ecs:ListTasks",
          "ecs:StopTask",
          "ecs:RunTask",
          "ecs:DescribeClusters"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Sid    = "AllowPassRole"
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = [
          "arn:aws:iam::*:role/*" # YOUR_CODEBUILD_SERVICE_ROLE
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_service_role_attachment" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = aws_iam_policy.codepipeline_service_policy.arn
}