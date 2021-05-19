# Configure Security Group for Default Region
resource "aws_security_group" "cloudevopsg" {
  name        = "${var.environment}-cloudevopsg"
  description = "Security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.cloudevopsvpc.id
  depends_on  = [aws_vpc.cloudevopsvpc]
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}"
    Environment = "${var.environment}-security-grp"
  }
}
