

resource "aws_security_group" "alb" {
  name        = "alb-security-group"
  description = "Allow inbound HTTP and HTTPS traffic"
  vpc_id      = var.vpc_id
}

resource "aws_lb" "application_lb" {
  name               = "application-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.subnets
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "app_target_group" {
  name        = "app-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}
