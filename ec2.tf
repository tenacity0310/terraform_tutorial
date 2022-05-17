# Naming the "aws_instance"
# To resize the volume, use "root_block_device" block
resource "aws_instance" "peter_terraform_ec2" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.peter_terrafrom_ami.id
  key_name               = aws_key_pair.peter_terraform_keypair.id
  vpc_security_group_ids = [aws_security_group.peter_terrform_security_group.id]
  subnet_id              = aws_subnet.peter_terraform_public_subnet.id

  root_block_device {
    volume_size           = 10
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "peter_ec2"
  }

}
