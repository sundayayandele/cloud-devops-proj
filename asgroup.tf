resource "aws_autoscaling_group" "cdevops" {
  name     = "cloud-devops-asg"
  max_size = 3
  min_size = 2
  desired_capacity = 2
  force_delete     = true
  #placement_group           = aws_placement_group.test.id
  launch_configuration = aws_launch_configuration.cdevops-launch-config.name
  vpc_zone_identifier  = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
  tag {
    key                 = "Name"
    value               = "Cloud-Devops-asg"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancers, target_group_arns]
  }

}

resource "aws_launch_configuration" "cdevops-launch-config" {
  name                        = "web_config"
  image_id                    = var.ami
  enable_monitoring           = true
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.tf_key.key_name
  user_data                   = file("userdata.sh")
  associate_public_ip_address = true
  security_groups             = [aws_security_group.cloudevopsg.id]
}
