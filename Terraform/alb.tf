resource "aws_lb" "main" {
  name               = "gemini-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public-1a.id, aws_subnet.public-1c.id]
}

resource "aws_lb_target_group" "main" {
  name        = "gemini-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.gemini-vpc.id
  target_type = "ip" # Fargateはip必須

  health_check {
    path = "/"
    matcher = "200"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}