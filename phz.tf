resource "aws_route53_zone" "private" {
  name = var.dns_phz
  comment = "Hosted zone for ITAU PY-${var.name_prefix} Account"

  vpc {
    vpc_id = aws_vpc.vpc.id
    vpc_region  = var.aws_region
  }
}

##Resolver rule association
resource "aws_route53_resolver_rule_association" "aws-itau" {
  name             = "ASSOCIATION-aws-itau"
  resolver_rule_id = "rslvr-rr-b72060edfaa64a7b8"
  vpc_id           = aws_vpc.vpc.id
}

resource "aws_route53_resolver_rule_association" "bancardnet" {
  name             = "ASSOCIATION-bancardnet"
  resolver_rule_id = "rslvr-rr-ce3476a5623247898"
  vpc_id           = aws_vpc.vpc.id
}

resource "aws_route53_resolver_rule_association" "interbanco" {
  name             = "ASSOCIATION-interbanco"
  resolver_rule_id = "rslvr-rr-9b072e5f73584934a"
  vpc_id           = aws_vpc.vpc.id
}

resource "aws_route53_resolver_rule_association" "itau" {
  name             = "ASSOCIATION-itau"
  resolver_rule_id = "rslvr-rr-1e813e58004c48ac8"
  vpc_id           = aws_vpc.vpc.id
}

resource "aws_route53_resolver_rule_association" "itaucasadebolsa" {
  name             = "ASSOCIATION-itaucasadebolsa"
  resolver_rule_id = "rslvr-rr-ba891644ceb24743a"
  vpc_id           = aws_vpc.vpc.id
}

resource "aws_route53_resolver_rule_association" "itauinvest" {
  name             = "ASSOCIATION-itauinvest"
  resolver_rule_id = "rslvr-rr-f4bcb34ea6d34d839"
  vpc_id           = aws_vpc.vpc.id
}