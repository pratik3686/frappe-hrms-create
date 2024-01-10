
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
      file("../scripts/install.sh")
    ]
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.companyName}-hrms-ec2"
  }


}
