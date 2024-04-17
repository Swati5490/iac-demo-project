resource "aws_key_pair" "jenkey123" {
  key_name                    =       var.key_name
  public_key                  =       var.public_key
}


resource "aws_instance" "jenkins_ec2_instance" {
  ami                         =       var.ami_id
  instance_type               =       var.instance_type
  tags                        =       {
            Name              =         var.tag_name
  }
  key_name                    =       var.key_name
  vpc_security_group_ids      =       [var.sg_for_jenkins]
  associate_public_ip_address =       var.enable_public_ip_address
  user_data                   =       var.user_data_install_jenkins

  provisioner "remote-exec" {
    inline                    = [
                                      "echo 'build ssh connection'"
                                ]
   }
  connection {
    host                      =       self.public_ip
    type                      =       "ssh"
    user                      =       "ubuntu"
    private_key               =       file("/Users/swati/Desktop/Projects/iac-demo-project/jenkey123")
  }

  provisioner "local-exec" {
    command                   =       "ansible-playbook -i ${aws_instance.jenkins_ec2_instance.public_ip}, --private-key ${var.key_name} playbook.yml"
  }
}
