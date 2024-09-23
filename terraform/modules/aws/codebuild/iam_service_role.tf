locals {
  default_permissions = [
    {
      effect    = "Allow"
      actions   = [
        "ecr:GetAuthorizationToken"
      ]
      resources = ["*"]
    },
    {
      effect    = "Allow"
      actions   = [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs"
      ]
      resources = ["*"]
    }  
  ]

  all_codebuild_service_role_permissions = concat(local.default_permissions, var.codebuild_service_role_permissions)
}


resource "aws_iam_role" "codebuild_service_role" {
  name = "${var.codebuild_project_name}-role"
  path = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          "Service" : "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_service_role" {
  name = "${var.codebuild_project_name}-policy"
  path = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat(
      [for perm in local.all_codebuild_service_role_permissions : {
        Effect   = perm.effect
        Action   = perm.actions
        Resource = perm.resources
      }]
    )
  })
}


resource "aws_iam_role_policy_attachment" "codebuild_service_role" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = aws_iam_policy.codebuild_service_role.arn
}

