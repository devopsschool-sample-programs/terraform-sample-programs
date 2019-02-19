##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {
  default = "scmgalaxy-key"
}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "AKIAI7FTWHE4UTLTF74Q"
  secret_key = "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"
  region     = "ap-south-1"

}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_instance" "nginx" {
  ami           = "ami-5b673c34"
  instance_type = "t2.micro"
  key_name        = "${var.key_name}"

  connection {
    user        = "ec2-user"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo service nginx start"
    ]
  }
}

##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
    value = "${aws_instance.nginx.public_dns}"
}
