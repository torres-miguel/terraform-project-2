# Create two security groups in the default VPC
resource "aws_security_group" "alb_sg1" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb_sg2" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Configure the ALB in the default VPC
resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg1.id, aws_security_group.alb_sg2.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  # Additional configuration can be added here
}