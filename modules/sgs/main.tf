resource "aws_security_group" "lb_security_group" {
  name                   = "${var.cluster_name}-${terraform.workspace}-lb"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = "true"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.whitelist_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "master_security_group" {
  name                   = "${var.cluster_name}-${terraform.workspace}-master"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = "true"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "core_security_group" {
  name                   = "${var.cluster_name}-${terraform.workspace}-core"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = "true"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "sns_source_addresses" {
  type              = "ingress"
  from_port         = 8443
  to_port           = 8443
  protocol          = "tcp"
  cidr_blocks       = var.sns_source_addresses
  security_group_id = aws_security_group.master_security_group.id
}

resource "aws_security_group_rule" "lb_to_master" {
  type                     = "ingress"
  from_port                = var.zeppelin_port
  to_port                  = var.zeppelin_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_security_group.id
  security_group_id        = aws_security_group.master_security_group.id
}

resource "aws_security_group_rule" "ssh_to_master" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.whitelist_ips
  security_group_id = aws_security_group.master_security_group.id
}

resource "aws_security_group_rule" "master_to_master" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = aws_security_group.master_security_group.id
  security_group_id        = aws_security_group.master_security_group.id
}

resource "aws_security_group_rule" "core_to_core" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = aws_security_group.core_security_group.id
  security_group_id        = aws_security_group.core_security_group.id
}

resource "aws_security_group_rule" "ssh_to_core" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.whitelist_ips
  security_group_id = aws_security_group.core_security_group.id
}

resource "aws_security_group_rule" "master_to_core" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = aws_security_group.master_security_group.id
  security_group_id        = aws_security_group.core_security_group.id
}

resource "aws_security_group_rule" "core_to_master" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = aws_security_group.core_security_group.id
  security_group_id        = aws_security_group.master_security_group.id
}
