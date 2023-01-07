resource "aws_launch_configuration" "example" {
  image_id        = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.instance.id]

  user_data = templatefile("${path.module}/user-data.sh", {
    db_address  = data.terraform_remote_state.db.outputs.address
    db_port     = data.terraform_remote_state.db.outputs.port
    server_port = var.server_port
    server_text = var.server_text
  })

  # Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  health_check_type    = "ELB"
  launch_configuration = aws_launch_configuration.example.name
  max_size             = var.max_size
  min_size             = var.min_size
  name                 = var.cluster_name
  target_group_arns    = [aws_lb_target_group.asg.arn]
  vpc_zone_identifier  = data.aws_subnets.default.ids

  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
    }
  }

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = var.cluster_name
  }

  dynamic "tag" {
    for_each = {
      for key, value in var.custom_tags :
      key => value
      if lower(key) != "name"
    }

    content {
      key                 = tag.key
      propagate_at_launch = true
      value               = tag.value
    }
  }
}

resource "aws_security_group" "instance" {
  name = "${var.cluster_name}-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }
}

resource "aws_lb" "example" {
  load_balancer_type = "application"
  name               = "${var.cluster_name}-alb"
  security_groups    = [aws_security_group.alb.id]
  subnets            = data.aws_subnets.default.ids
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = local.http_port
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "asg" {
  name     = "${var.cluster_name}-alb"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    healthy_threshold   = 2
    interval            = 15
    matcher             = "200"
    path                = "/"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    target_group_arn = aws_lb_target_group.asg.arn
    type             = "forward"
  }
}

resource "aws_security_group" "alb" {
  name = "${var.cluster_name}-alb"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  cidr_blocks       = local.all_ips
  from_port         = local.http_port
  protocol          = local.tcp_protocol
  security_group_id = aws_security_group.alb.id
  to_port           = local.http_port
  type              = "ingress"
}

resource "aws_security_group_rule" "allow_all_outbound" {
  cidr_blocks       = local.all_ips
  from_port         = local.any_port
  protocol          = local.any_protocol
  security_group_id = aws_security_group.alb.id
  to_port           = local.any_port
  type              = "egress"
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  count = var.enable_autoscaling ? 1 : 0

  autoscaling_group_name = aws_autoscaling_group.example.name
  desired_capacity       = 10
  max_size               = 10
  min_size               = 2
  recurrence             = "0 9 * * *"
  scheduled_action_name  = "${var.cluster_name}-scale-out-during-business-hours"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  count = var.enable_autoscaling ? 1 : 0

  autoscaling_group_name = aws_autoscaling_group.example.name
  desired_capacity       = 2
  max_size               = 10
  min_size               = 2
  recurrence             = "0 17 * * *"
  scheduled_action_name  = "${var.cluster_name}-scale-in-at-night"
}
