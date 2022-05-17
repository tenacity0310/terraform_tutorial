# Naming the data source "aws_ami"
# attribute "most recent" and "owners" should be specified.
# "owners" is plural: mostly, the attribute's value should be made in the bracket list, whose vaule is the owner id.
# For the "values" attribute, put into the AMI name value on the AWS console
data "aws_ami" "peter_terrafrom_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}
