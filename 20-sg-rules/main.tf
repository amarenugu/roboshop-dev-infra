#MongoDB allowing connections from Catalogue on port 27017
resource "aws_security_group_rule" "mongodb_catalogue" {
    type        = "ingress"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    source_security_group_id = local.catalogue_sg_id
    security_group_id = local.mongodb_sg_id
}

#MongoDB allowing connections from user on port 27017
resource "aws_security_group_rule" "mongodb_user" {
    type        = "ingress"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    source_security_group_id = local.user_sg_id
    security_group_id = local.mongodb_sg_id
}

#MongoDB allowing connections from bastion on port 22
resource "aws_security_group_rule" "mongodb_bastion" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.bastion_sg_id
    security_group_id = local.mongodb_sg_id
}

#redis allowing connections from user on port 6379
resource "aws_security_group_rule" "redis_user" {
    type        = "ingress"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    source_security_group_id = local.user_sg_id
    security_group_id = local.redis_sg_id
}

#redis allowing connections from cart on port 6379
resource "aws_security_group_rule" "redis_cart" {
    type        = "ingress"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    source_security_group_id = local.cart_sg_id
    security_group_id = local.redis_sg_id
}

#redis allowing connections from bastion on port 22
resource "aws_security_group_rule" "redis_bastion" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.bastion_sg_id
    security_group_id = local.redis_sg_id
}

#mysql allowing connections from shipping on port 3306
resource "aws_security_group_rule" "mysql_shipping" {
    type        = "ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    source_security_group_id = local.shipping_sg_id
    security_group_id = local.mysql_sg_id
}

#mysql allowing connections from bastion on port 22
resource "aws_security_group_rule" "mysql_bastion" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.bastion_sg_id
    security_group_id = local.mysql_sg_id
}

#rabbitmq 
resource "aws_security_group_rule" "rabbitmq_payment" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.payment_sg_id
    security_group_id = local.rabbitmq_sg_id
}

resource "aws_security_group_rule" "rabbitmq_bastion" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.bastion_sg_id
    security_group_id = local.rabbitmq_sg_id
}

#Catalogue
resource "aws_security_group_rule" "catalogue_backend_alb" {
    type        = "ingress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    source_security_group_id = local.backend_alb_sg_id
    security_group_id = local.catalogue_sg_id
}

resource "aws_security_group_rule" "catalogue_bastion" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.bastion_sg_id
    security_group_id = local.catalogue_sg_id
}

#User

resource "aws_security_group_rule" "user_backend_alb" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.backend_alb_sg_id
    security_group_id = local.user_sg_id
}

resource "aws_security_group_rule" "user_bastion" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.bastion_sg_id
    security_group_id = local.user_sg_id
}

#Cart
resource "aws_security_group_rule" "cart_backend_alb" {
    type        = "ingress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    source_security_group_id = local.backend_alb_sg_id
    security_group_id = local.cart_sg_id
}

resource "aws_security_group_rule" "cart_bastion" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.bastion_sg_id
    security_group_id = local.cart_sg_id
}

#Shipping
resource "aws_security_group_rule" "shipping_backend_alb" {
    type        = "ingress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    source_security_group_id = local.backend_alb_sg_id
    security_group_id = local.shipping_sg_id
}

resource "aws_security_group_rule" "shipping_bastion" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.bastion_sg_id
    security_group_id = local.shipping_sg_id
}

#Payment
resource "aws_security_group_rule" "payment_backend_alb" {
    type        = "ingress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    source_security_group_id = local.backend_alb_sg_id
    security_group_id = local.payment_sg_id
}

resource "aws_security_group_rule" "payment_bastion" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.bastion_sg_id
    security_group_id = local.payment_sg_id
}

#Backend_alb, HTTP based
resource "aws_security_group_rule" "backend_alb_frontend" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    source_security_group_id = local.frontend_sg_id
    security_group_id = local.backend_alb_sg_id
}

#Backend_alb, HTTP based
resource "aws_security_group_rule" "backend_alb_bastion" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    source_security_group_id = local.bastion_sg_id
    security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_catalogue" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    source_security_group_id = local.catalogue_sg_id
    security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_user" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    source_security_group_id = local.user_sg_id
    security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_cart" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    source_security_group_id = local.cart_sg_id
    security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_shipping" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    source_security_group_id = local.shipping_sg_id
    security_group_id = local.backend_alb_sg_id
}

#Frontend
resource "aws_security_group_rule" "frontend_frontend_alb" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    source_security_group_id = local.frontend_alb_sg_id
    security_group_id = local.frontend_sg_id
}

resource "aws_security_group_rule" "frontend_bation" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    source_security_group_id = local.bastion_sg_id
    security_group_id = local.frontend_sg_id
}

#Frontend_alb
resource "aws_security_group_rule" "frontend_alb_https" {
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = local.frontend_alb_sg_id
}

resource "aws_security_group_rule" "frontend_alb_http" {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = local.frontend_alb_sg_id
}

#Bastion

resource "aws_security_group_rule" "bastion_my_public_ip" {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_public_ip.response_body)}/32"]
    security_group_id = local.bastion_sg_id
}