resource "aws_instance" "mongodb" {
    ami                     = data.aws_ami.joindevops.id
    instance_type           = "t3.micro"
    vpc_security_group_ids  = [local.mongodb_sg_id]
    subnet_id               = local.database_subnet_id
    user_data               = file("${path.module}/user-data.sh")

    tags = merge (
        {
            Name =  "${local.common_name}-mongodb"
        },
        local.common_tags
    )

}


resource "terraform_data" "mongodb" {
    triggers_replace =[
        aws_instance.mongodb.id
    ]

    connection {
        type        = "ssh"
        user        = "ec2-user"
        password    = "DevOps-321"
        host        = aws_instance.mongodb.private_ip
        timeout     = "3m"
    }

    provisioner "file" {
        source      = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
        ]
    }
}


resource "aws_instance" "redis" {
    ami                     = data.aws_ami.joindevops.id
    instance_type           = "t3.micro"
    vpc_security_group_ids  = [local.redis_sg_id]
    subnet_id               = local.database_subnet_id
    user_data               = file("${path.module}/user-data.sh")
    key_name                = "roboshop-key-rsa"

    tags = merge (
        {
            Name =  "${local.common_name}-redis"
        },
        local.common_tags
    )

}

resource "terraform_data" "redis" {
    triggers_replace =[
        aws_instance.redis.id
    ]

    connection {
        type        = "ssh"
        user        = "ec2-user"
        private_key = file("~/.ssh/roboshop-rsa")
        host        = aws_instance.redis.private_ip
    }

    provisioner "file" {
        source      = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh redis ${var.environment}"
        ]
    }
}