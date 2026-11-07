resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.http_listener.port
  protocol          = var.http_listener.protocol

  default_action {
    type = var.http_listener.default_action_type

    redirect {
      protocol    = var.http_listener.redirect.protocol
      port        = var.http_listener.redirect.port
      status_code = var.http_listener.redirect.status_code
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  certificate_arn   = var.acm_arn
  port              = var.https_listener.port
  protocol          = var.https_listener.protocol
  ssl_policy        = var.https_listener.ssl_policy

  default_action {
    type = var.https_listener.default_action_type

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.test_listener.port
  protocol          = var.test_listener.protocol
  ssl_policy        = var.test_listener.ssl_policy
  certificate_arn   = var.acm_arn

  default_action {
    type = var.test_listener.default_action_type

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}
