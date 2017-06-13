#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-a4f9f2c2
#
# Your subnet ID is:
#
#     subnet-7aba681d
#
# Your security group ID is:
#
#     sg-00100979
#
# Your Identity is:
#
#     hdays-michel-lion
#
#module "example" {
#  source = "./example-module"
#  command = "echo 'Bye world!'"
#}

terraform {
  backend "atlas" {
    name = "olindata/training"
  }
}

variable "aws_access_key" {
  type        = "string"
  description = "This is the AWS access key to use"
}

variable "aws_secret_key" {
  type        = "string"
  description = "This is the AWS secret key of the account that will be used to interact with AWS"
}

variable "aws_region" {
  type        = "string"
  description = "The region we create our resources in"
  default     = "eu-west-1"
}

variable "ami" {
  type = "string"
  description = "The AMI to use"
  default = "ami-a4f9f2c2"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
  count                  = "2"
  subnet_id              = "subnet-7aba681d"
  vpc_security_group_ids = ["sg-00100979"]

  tags {
    Identity   = "hdays-michel-lion"
    Name = "Web ${count.index + 1} / 2" 
    Sometag    = "Yourmom"
    Anothertag = "Stuffhere"
  }
}

output "public_ip" {
  value       = [ "${aws_instance.web.*.public_ip}" ]
  description = "The public IP of the instance we create"
}

output "public_dns" {
  value       = [ "${aws_instance.web.*.public_dns}" ]
  description = "The public DNS of the instance we create"
}
