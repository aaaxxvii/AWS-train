# ALB用 SG
resource "aws_security_group" "alb" {
  name        = "gemini-sg-alb"
  description = "Allow HTTP from Internet"
  vpc_id      = aws_vpc.gemini-vpc.id

  # 受信: インターネットからのHTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 送信: 全許可
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# App用 SG
resource "aws_security_group" "app" {
  name        = "gemini-sg-app"
  description = "Allow 8080 from ALB"
  vpc_id      = aws_vpc.gemini-vpc.id

  # 受信: 8080番 (0.0.0.0/0 で許可)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 送信: 全許可 (これがないと504エラーになる)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}