# Naming the keypair "aws_key_pair"
# Using the file path function to locate the key for better security
resource "aws_key_pair" "peter_terraform_keypair" {
  key_name   = "id_ed25519_peter"
  public_key = file("~/.ssh/id_ed25519_peter.pub")
}
