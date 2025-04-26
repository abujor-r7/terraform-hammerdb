variable "aws_region" {
  description = "AWS region"
  default     = "eu-central-1"
}

variable "aws_account_id" {
  description = "AWS account ID"
  default     = "042293964381"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  default = "10.0.0.0/20"
}

variable "public_subnet_b_cidr" {
  default = "10.0.16.0/20"
}

variable "public_subnet_c_cidr" {
  default = "10.0.32.0/20"
}

variable "key_pair_name" {
  description = "Name of the key pair to use for SSH access"
  default = "aleksa-key"
}
variable "bastion_ami" {
  description = "AMI ID for the bastion host"
  default     = "ami-0d8d11821a1c1678b" 
}
# aws ec2 describe-images \
#   --owners amazon \
#   --filters "Name=name,Values=al2023-ami-2023*-x86_64" \
#             "Name=state,Values=available" \
#   --query 'Images[*].[ImageId,CreationDate]' \
#   --region eu-central-1 \
#   --output text | sort -k2 -r | head -n 1
