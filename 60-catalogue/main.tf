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


