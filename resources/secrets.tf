data "aws_secretsmanager_secret" "rds_credentials" {
  name = "rds_testing/credentials"
}
data "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id = data.aws_secretsmanager_secret.rds_credentials.id
}
locals {
  rds_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds_credentials_version.secret_string)
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
