# Retrieve the default VPC
data "aws_vpc" "default" {
  default = true
}

# Create two subnets in the default VPC
resource "aws_subnet" "subnet1" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = "172.31.192.0/28"
  availability_zone = "eu-central-1a" # Replace with actual availability zone
    tags = {
    Name = "Subnet1a"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = "172.31.192.64/28"
  availability_zone = "eu-central-1c" # Replace with actual availability zone
      tags = {
    Name = "Subnet1c"
  }
}
