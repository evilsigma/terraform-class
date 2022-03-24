resource "aws_launch_configuration" "this" {
  name          = "lgc-ue1-${var.proy}-${var.env}-web-03"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name = data.aws_key_pair.this.key_name
  security_groups = [aws_security_group.sg_web.id]

}

resource "aws_autoscaling_group" "this" {

  desired_capacity   = 1
  max_size           = 4
  min_size           = 1
  vpc_zone_identifier  = [data.aws_subnet.subnet_publica.id, data.aws_subnet.subnet_publica2.id]
  health_check_type = "ELB"
  target_group_arns = [var.tg_arn]
  launch_configuration      = aws_launch_configuration.this.name
}


resource "aws_security_group" "sg_web" {
  name        = "SG-ue1-${var.proy}-${var.env}-web-03"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [data.aws_vpc.this.cidr_block]
  }
  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [data.aws_vpc.this.cidr_block]
  }

    ingress {
    description      = "SSH from Internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

   tags = {
    Name = "ec2-ue1-${var.proy}-${var.env}-03"
    Ambiente = var.env
    Proyecto = var.proy
  }
}


resource "aws_autoscaling_policy" "this" {
  name                   = "pol-ue1-${var.proy}-${var.env}-web-01"
  scaling_adjustment     = 1
  cooldown               = 30
  adjustment_type = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.this.name
  policy_type = "SimpleScaling"

}

resource "aws_cloudwatch_metric_alarm" "this" {
    alarm_name = "web-cpu-alarm"
    alarm_description = "web-cpu-alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "300"
    statistic = "Average"
    threshold = "60"
    dimensions = {
      "AutoScalingGroupName" = "${aws_autoscaling_group.this.name}"
      }
    actions_enabled = true
    alarm_actions = ["${aws_autoscaling_policy.this.arn}"]
}

resource "aws_autoscaling_notification" "this" {
  group_names = [
    aws_autoscaling_group.this.name
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.this.arn
}

resource "aws_sns_topic" "this" {
  name = "sns-ue1-${var.proy}-${var.env}-web-01"

}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.email
}

