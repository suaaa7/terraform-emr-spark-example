resource "aws_lb" "master_lb" {
  name               = "${var.cluster_name}-${terraform.workspace}"
  load_balancer_type = "application"
  security_groups    = [var.lb_security_group]
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "zeppelin" {
  name     = "${var.cluster_name}-zeppelin-${terraform.workspace}"
  port     = var.zeppelin_port
  protocol = "HTTPS"
  vpc_id   = var.vpc_id

  health_check {
    protocol = "HTTPS"
    path     = "/"
    matcher  = "200"

    healthy_threshold   = 2
    unhealthy_threshold = 2

    interval = 10
    timeout  = 2
  }
}

resource "aws_lb_target_group_attachment" "zeppelin" {
  target_group_arn = aws_lb_target_group.zeppelin.arn
  target_id        = var.master_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "ssl" {
  load_balancer_arn = aws_lb.master_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.lb_cert_arn

  default_action {
    target_group_arn = aws_lb_target_group.zeppelin.arn
    type             = "forward"
  }
}
