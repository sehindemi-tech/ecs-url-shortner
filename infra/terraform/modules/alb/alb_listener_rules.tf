resource "aws_lb_listener_rule" "prod" {
  for_each = var.listener_rules

  listener_arn = aws_lb_listener.https.arn
  priority     = each.value.priority

  action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.this[each.value.blue_target_group].arn
        weight = 100
      }
      target_group {
        arn    = aws_lb_target_group.this[each.value.green_target_group].arn
        weight = 0
      }
    }
  }

  condition {
    host_header {
      values = [each.value.host]
    }
  }

  lifecycle {
    ignore_changes = [
      action
    ]
  }
}

resource "aws_lb_listener_rule" "test" {
  for_each = var.listener_rules

  listener_arn = aws_lb_listener.test.arn
  priority     = each.value.priority

  action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.this[each.value.blue_target_group].arn
        weight = 0
      }
      target_group {
        arn    = aws_lb_target_group.this[each.value.green_target_group].arn
        weight = 100
      }
    }
  }

  condition {
    host_header {
      values = [each.value.host]
    }
  }

  lifecycle {
    ignore_changes = [
      action
    ]
  }
}
