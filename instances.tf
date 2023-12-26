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
