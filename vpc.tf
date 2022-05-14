# "aws_vpc": aws rescource vpc ----> name can't be changed
# "peter_terraform_vpc": the logical name of the VPC on terrafrom to make reference in the future, that won't be showed on AWS
resource "aws_vpc" "peter_terraform_vpc" {
  cidr_block           = "10.87.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    # naming VPC in AWS Console
    Name = "peter_vpc"
  }
}
