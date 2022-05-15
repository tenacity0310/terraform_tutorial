#--- 1st way ----
# Naming the "aws_route_table" resource
resource "aws_route_table" "peter_terraform_route_table" {
  vpc_id = aws_vpc.peter_terraform_vpc.id

  tags = {
    Name = "peter_route_table"
  }
}

# add "aws_route" resource
# adding the above "routetable" id
# destination_cidr_block ----> The range of IP addresses where you want traffic to go
resource "aws_route" "peter_terraform_route" {
  route_table_id         = aws_route_table.peter_terraform_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.peter_terraform_internet_gateway.id
}

# add "aws_route_table_association" resource to connect "subnet" and "route_table"
resource "aws_route_table_association" "peter_terraform_rt_association" {
  subnet_id      = aws_subnet.peter_terraform_public_subnet.id
  route_table_id = aws_route_table.peter_terraform_route_table.id
}


# --- 2nd way -----
### Naming the "aws_route_table" resource
#
#resource "aws_route_table" "peter_terraform_route_table" {
#   vpc_id = aws_vpc.peter_terraform_vpc.id
#
#   route {
#	cidr_block= "0.0.0.0/0"
#        gateway_id = aws_internet_gateway.peter_terraform_internet_gateway.id
#}
#
#   tags = {
#	Name = "peter_route_table"
#}
#
#}
# add "aws_route_table_association" resource to connect "subnet" and "route_table"
#resource "aws_route_table_association" "peter_terraform_rt_association"{

#   subnet_id = aws_subnet.peter_terraform_public_subnet.id
#   route_table_id = aws_route_table.peter_terraform_route_table.id

#}
