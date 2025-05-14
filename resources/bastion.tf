resource "aws_instance" "bastion_host" {
  ami                         = var.bastion_ami
  instance_type               = "t2.micro"
  subnet_id                   = element([aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id], 0)
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.bastion_profile.name

  tags = {
    Name = "bastion-host"
  }
}
