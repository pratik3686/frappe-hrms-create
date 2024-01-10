
resource "aws_instance" "master" {
  
   ami = data.aws_ami.ubuntu.id
   instance_type = var.instanceType
   key_name = "gaction1"

  connection {
    host = self.public_ip
    type = "ssh"
    private_key = file("../scripts/id_rsa")
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

output "hrms_public_ip" {
  value = aws_instance.master.public_dns
}