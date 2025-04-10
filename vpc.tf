data "aws_vpc" "default_vpc" {
  id = "vpc-0865a7d47d448b761"  
}
data "aws_subnet" "public_a" {
  id = "subnet-06280be2f0ccb3bf7"  
}
data "aws_subnet" "public_b" {
  id = "subnet-022708d9ca6338230"  
}
data "aws_subnet" "public_c" {
  id = "subnet-0eb84a6f138f536b7"  
}