data "aws_secretsmanager_secret" "aleksa_testbed" {
  name = "aleksa/testbed"
}

data "aws_secretsmanager_secret_version" "bastion_key" {
  secret_id = "bastion/ssh-private-key"
}

resource "null_resource" "write_bastion_key" {
  provisioner "local-exec" {
    command = <<EOT
echo '${data.aws_secretsmanager_secret_version.bastion_key.secret_string}' > ~/.ssh/bastion_key.pem
chmod 400 ~/.ssh/bastion_key.pem
EOT
  }
}
