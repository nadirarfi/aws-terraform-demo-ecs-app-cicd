resource "aws_iam_role" "codebuild_assumable_role" {
  name = "${var.codebuild_project_name}-assumable-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "codebuild_assumable_role_policy" {
  name = "${var.codebuild_project_name}-assumable-role-policy"
  description = "Policy for the codebuild_assumable_role"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # For frontend/backend
      {
        Effect: "Allow",
        Action = [
          "ssm:*"
        ],
        Resource: "*"
      },
      # For backend
      {
        Effect = "Allow",
        Action = [
          "ecs:DescribeServices", 
          "ecs:DescribeTaskDefinition",
          "ecs:ListServices",
          "ecs:ListTasks" 
        ],
        Resource = "*"
      },
      # For codebuild frontend
      {
        Effect = "Allow",
        Action = [
          "s3:*"
        ],
        Resource = "*"
      }      
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_assumable_policy_attachment" {
  role       = aws_iam_role.codebuild_assumable_role.name
  policy_arn = aws_iam_policy.codebuild_assumable_role_policy.arn
}

resource "aws_ssm_parameter" "codebuild_assumable_role_arn" {
  type  = "String"
  name  = var.ssm_codebuild_assumable_role_arn_key
  value = aws_iam_role.codebuild_assumable_role.arn
}
