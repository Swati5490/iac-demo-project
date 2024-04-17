data "aws_vpc" "default" {
  default = true
}
module "security-group" {
    source              = "./security-group"
    ec2_sg_name         = "SG for EC2 to enable SSH(22) and HTTP(80)"
    vpc_id              = "${data.aws_vpc.default.id}"
}
module "ec2" {
    source = "./ec2"
    ami_id                    =     var.ami_id
    instance_type             =     var.instance_type
    public_key                =     var.public_key
    enable_public_ip_address  =     true
    tag_name                  =     var.tag_name
    key_name                  =     var.key_name
    user_data_install_jenkins =     templatefile("./jenkins-runner-script/jenkins-installer.sh", {})
    sg_for_jenkins            =     module.security-group.sg_ec2_sg_ssh_http_id
}