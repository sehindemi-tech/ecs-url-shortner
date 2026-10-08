resource "aws_flow_log" "vpc_flow_log" {
  iam_role_arn         = aws_iam_role.vpc_flow_log_role.arn
  vpc_id               = aws_vpc.url_shortner.id
  log_destination      = var.vpc_flow_log_settings.log_destination
  log_destination_type = var.vpc_flow_log_settings.log_destination_type
  traffic_type         = var.vpc_flow_log_settings.traffic_type
  tags = {
    Name = "${var.project_settings.project_name}-vpc-flow-log"
  }
}

resource "aws_iam_role" "vpc_flow_log_role" {
  name               = "${var.project_settings.project_name}-vpc-flow-log-role"
  assume_role_policy = data.aws_iam_policy_document.vpc_flow_log_role_assume_role_policy.json
}


resource "aws_iam_role_policy" "vpc_flow_log_role_policy" {
  name   = "${var.project_settings.project_name}-vpc-flow-log-role-policy"
  policy = data.aws_iam_policy_document.vpc_flow_log_role_policy.json
  role   = aws_iam_role.vpc_flow_log_role.id
}

data "aws_iam_policy_document" "vpc_flow_log_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "vpc_flow_log_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["${var.vpc_flow_log_settings.log_destination}:*"]
  }
}
