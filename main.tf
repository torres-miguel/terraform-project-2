# Define AWS provider
provider "aws" {
  region = "eu-central-1"
}

# Create a key pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/aws_rsa.pub") # Replace with your public key path
}

# Create a security group
resource "aws_security_group" "instance_sg" {
  name        = "instance_security_group"
  
  # SSH access
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define resource for Ubuntu instances
resource "aws_instance" "ubuntu" {
  count         = 2
  ami           = "ami-0faab6bdbac9486fb"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  subnet_id =   "subnet-03bcba6164fb25711"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y nginx
              echo "Hola from ${count.index + 1}" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = "UbuntuInstance${count.index + 1}"
  }
}

output "instance_ips" {
  value = aws_instance.ubuntu[*].public_ip
}
