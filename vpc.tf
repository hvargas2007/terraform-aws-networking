# VPC Produccion Definition 
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = merge(var.project-tags, { Name = "${var.name_prefix}-Vpc" }, )
}

# Private Subnet Produccion Definition
resource "aws_subnet" "private" {
  for_each          = { for i, v in var.PrivateSubnet : i => v }
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(var.project-tags, { Name = "${each.value.name}" }, )
}

# Private Subnet Produccion Definition
resource "aws_subnet" "privatedb" {
  for_each          = { for i, v in var.PrivateSubnetDb : i => v }
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(var.project-tags, { Name = "${each.value.name}" }, )
}

#transit gateway attachment Produccion
resource "aws_ec2_transit_gateway_vpc_attachment" "transit_attachment" {
  count              = 1
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = aws_vpc.vpc.id
  subnet_ids         = [aws_subnet.private[count.index].id]

  tags = merge(var.project-tags, { Name = "${var.name_prefix}-Attach" }, )
}

# Private Route Table 
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    transit_gateway_id = var.transit_gateway_id
  }

  route {
    cidr_block     = "10.0.0.0/8"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = merge(var.project-tags, { Name = "PrivateRoute" }, )
}

# Private Subnets Produccion Association
resource "aws_route_table_association" "private" {
  count          = length(var.PrivateSubnet)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private1" {
  count          = length(var.PrivateSubnetDb)
  subnet_id      = aws_subnet.privatedb[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

# VPC Produccion Flow Logs to CloudWatch
resource "aws_flow_log" "VpcFlowLogProduccion" {
  iam_role_arn    = aws_iam_role.vpc_fl_policy_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_log_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.vpc.id
}