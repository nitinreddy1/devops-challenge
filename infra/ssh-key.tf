resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}

resource "local_file" "save_ssh_key" {
  content  = tls_private_key.ec2_private_key.private_key_pem
  filename = "${var.key_name}.pem"
}
