# Naming the "aws_security_group" resource
# no need to use "tags" for "name", since "aws_security_group" has the "name" attribute

resource "aws_security_group" "peter_terrform_security_group" {
  name        = "peter_security_group"
  description = "peter security group using terraform"
  vpc_id      = aws_vpc.peter_terraform_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


