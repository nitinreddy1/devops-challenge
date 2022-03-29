resource "aws_lb" "alb" {
  name               = "web-app"
  security_groups    = [aws_security_group.sg_alb.id]
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404; page not found"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "alb_tg" {
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "alb_listener_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.web_host.id
  port             = 80
}
