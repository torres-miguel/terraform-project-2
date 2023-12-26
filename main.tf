# Define AWS provider
provider "aws" {
  region = "eu-central-1"
}

# Create a key pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/aws_rsa.pub") # Replace with your public key path
}

