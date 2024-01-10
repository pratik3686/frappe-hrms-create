

data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

output "test" {
  value = data.aws_ami.ubuntu
}


resource "aws_instance" "master" {
  
   ami = data.aws_ami.ubuntu.id
   instance_type = var.instanceType
   key_name = "gaction1"


  connection {
    host = self.public_ip
    type = "ssh"
    private_key = file("~/.ssh/gaction1.pem")
    user = "ubuntu"
  }
  provisioner "remote-exec" {
    inline = [
      file("modules/scripts/install.sh")
    ]
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.companyName}-ec2"
  }


}