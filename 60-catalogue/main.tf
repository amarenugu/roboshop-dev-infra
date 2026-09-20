resource "aws_instance" "catalogue" {
    ami                     = local.ami_id
    instance_type           = "t3.micro"
    vpc_security_group_ids  = [local.catalogue_sg_id]
    subnet_id               = local.private_subnet_id
    key_name                = "roboshop-key-rsa"
    
    tags = merge (
        {
            Name =  "${local.common_name}-catalogue"
        },
        local.common_tags
    )

}

resource "terraform_data" "catalogue" {
    triggers_replace =[
        aws_instance.catalogue.id
    ]

    connection {
        type        = "ssh"
        user        = "ec2-user"
        #private_key = file("~/.ssh/roboshop-rsa")
        password    = "DevOps321"
        host        = aws_instance.catalogue.private_ip
    }

    provisioner "file" {
        source      = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh catalogue ${var.environment} ${var.app_version}"
        ]
    }
}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id   = aws_instance.catalogue.id
  state         = "stopped" 
  depends_on    = [terraform_data.catalogue]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.common_name}-catalogue-${var.app_version}-${aws_instance.catalogue.id}" #roboshop-dev-catalogue-v3-id
  source_instance_id = aws_instance.catalogue.id
  depends_on         = [aws_ec2_instance_state.catalogue]

    tags = merge (
        {
            Name =  "${local.common_name}-catalogue-${var.app_version}-${aws_instance.catalogue.id}"
        },
        local.common_tags
    )
}

resource "aws_launch_template" "catalogue" {
  name = "${local.common_name}-catalogue"
  image_id = aws_ami_from_instance.catalogue.id #AMI ID
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  key_name = "roboshop-key-rsa"
  vpc_security_group_ids = [local.catalogue_sg_id]
  update_default_version = true

  tag_specifications {
    resource_type = "instance"

    tags = merge (
        {
            Name =  "${local.common_name}-catalogue-${var.app_version}-${aws_instance.catalogue.id}"
        },
        local.common_tags
    )
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge (
        {
            Name =  "${local.common_name}-catalogue-${var.app_version}-${aws_instance.catalogue.id}"
        },
        local.common_tags
    )
  }
  
  tags = merge (
        {
            Name =  "${local.common_name}-catalogue-${var.app_version}-${aws_instance.catalogue.id}"
        },
        local.common_tags
    )
}

resource "aws_lb_target_group" "catalogue" {
  name                  = "${local.common_name}-catalogue"
  port                  = 8080
  protocol              = "HTTP"
  vpc_id                = local.vpc_id
  deregistration_delay  = 30

  health_check {
    healthy_threshold   = 2
    interval            = 10
    matcher             = "200-299"
    path                = "/health"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2

  }
}

resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.common_name}-catalogue"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 120
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = false
  
  launch_template {
    id      = aws_launch_template.catalogue.id
    version = "$Latest"
  }

  vpc_zone_identifier       = [local.private_subnet_id]
  target_group_arns         = [aws_lb_target_group.catalogue.arn] #Autoscaling launches into specific target group

  dynamic "tag" {
    for_each = merge(
        {
            Name = "${local.common_name}-catalogue"
        },
        local.common_tags
    )
    content{
    key                 = tag.key
    value               = tag.value
    propagate_at_launch = true
    }
  }
  
  #with in 15 mins autoscalring should be succesful
  timeouts {
    delete = "15m"
  }

}



resource "aws_autoscaling_policy" "catalogue" {
  autoscaling_group_name        = aws_autoscaling_group.catalogue.name
  name                          = "${local.common_name}-catalogue"
  policy_type                   = "TargetTrackingScaling"
  estimated_instance_warmup     = 120
  target_tracking_configuration {
    predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
        
      }

      target_value = 75.0

    
  }

}