# Create the subnet, naming resources subnet
# cidr_block of subnet should be smaller than vpc aws_vpc.peter_terraform_vpc range: 10.87.0.0/16
# map_public_ip_on_launch ---> Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
resource "aws_subnet" "peter_terraform_public_subnet" {
  vpc_id                  = aws_vpc.peter_terraform_vpc.id
  cidr_block              = "10.87.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1a"

  # Naming the subnet on AWS console
  tags = {
    Name = "peter_public_subnet"
  }
}
