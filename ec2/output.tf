output "sg_id_ec2" {
  value        =        aws_instance.jenkins_ec2_instance.vpc_security_group_ids
}