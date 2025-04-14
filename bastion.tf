resource "aws_instance" "bastion_host" {
  ami                         = var.bastion_ami
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_a.id
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = [aws_security_group.hammerdb_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "bastion-host"
  }
}
