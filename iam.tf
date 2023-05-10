# VPC Flow Logs IAM Policy Document
data "aws_iam_policy_document" "vpc_fl_policy_source" {
  statement {
    sid    = "SendVPCFlowLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
  }
}

# VPC Flow Logs IAM Role Policy Document
data "aws_iam_policy_document" "vpc_fl_role_source" {
  statement {
    sid    = "VPCFlowLogs"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# VPC Flow Logs IAM Policy
resource "aws_iam_policy" "vpc_fl_policy" {
  name        = "${var.name_prefix}-VPCFlowLogsPolicy"
  path        = "/"
  description = "VPC Flow Logs"
  policy      = data.aws_iam_policy_document.vpc_fl_policy_source.json
  tags        = { Name = "${var.name_prefix}-VPCFlowLogs-Policy" }
}

# VPC Flow Logs IAM Role (vpc_fl_ Task Execution role)
resource "aws_iam_role" "vpc_fl_policy_role" {
  name               = "${var.name_prefix}-VPCFlowLogsRole"
  assume_role_policy = data.aws_iam_policy_document.vpc_fl_role_source.json
  tags               = { Name = "${var.name_prefix}-VPCFlowLogs-Role" }
}

# Attach VPC Flow Logs Role and Policy
resource "aws_iam_role_policy_attachment" "vpc_fl_attach" {
  role       = aws_iam_role.vpc_fl_policy_role.name
  policy_arn = aws_iam_policy.vpc_fl_policy.arn
}