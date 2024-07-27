resource "aws_security_group" "allow_tls_SG" {
  name        = "allow_tls"
  vpc_id      = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = var.security_groups_ingress
    content {
      description = "Ingress rule"
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  dynamic "egress" {
    for_each = var.security_groups_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = [egress.value.cidr_blocks]
    }
  }

  tags = {
    Name = "${var.project_name}-allow_tls_SG"
  }
}