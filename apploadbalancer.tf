resource "aws_lb" "cdevops-alb" {
  name               = "cdevops-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.cloudevopsg.id]
  subnets            = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]

  enable_deletion_protection = false
  tags = {
    Name = "cdevops-alb"
  }
}

resource "aws_lb_target_group" "cdevops-alb" {
  name     = "cdevops-alb"
  port     = 80
  protocol = "HTTP"
  stickiness {
    type = "lb_cookie"
  }
  vpc_id = aws_vpc.cloudevopsvpc.id
}

resource "aws_lb_listener" "cdevops-alb" {
  load_balancer_arn = aws_lb.cdevops-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cdevops-alb.arn
  }
}
