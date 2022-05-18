# Naming the "aws_instance"
# To resize the volume, use "root_block_device" block
# Add "user_data" with the "file" function to boostrap with "userdata.tpl"
resource "aws_instance" "peter_terraform_ec2" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.peter_terrafrom_ami.id
  key_name               = aws_key_pair.peter_terraform_keypair.id
  vpc_security_group_ids = [aws_security_group.peter_terrform_security_group.id]
  subnet_id              = aws_subnet.peter_terraform_public_subnet.id
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size           = 10
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "peter_ec2"
  }

}
