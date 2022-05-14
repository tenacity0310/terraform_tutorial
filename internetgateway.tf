# Naming the internet gateway "aws_internet_gateway" "peter_terraform_internet_gateway"

resource "aws_internet_gateway" "peter_terraform_internet_gateway" {
  vpc_id = aws_vpc.peter_terraform_vpc.id

  tags = {
    Name = "peter_terraform_internet_gateway"
  }
}
