variable "ami_id" {}
variable "key_name" {}
variable "docker_username" {}
variable "docker_password" {}
variable "vpc_id" {}
variable "subnet_id" {}
variable "authorised_cidr_block" {}
variable "region" {
  default = "us-east-1"
}
