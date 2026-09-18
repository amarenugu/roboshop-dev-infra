#mongodb-dev-roboshop.online
resource "aws_route53_record" "mongodb" {
    zone_id     = var.zone_id
    name        = "mongodb-${var.environment}.${var.domain_name}" #mongodb-dev.ammienugu.online
    type        = "A"
    ttl         = 1
    records      = [aws_instance.mongodb.private_ip]
    allow_overwrite = true

}

resource "aws_route53_record" "redis" {
    zone_id     = var.zone_id
    name        = "redis-${var.environment}.${var.domain_name}" #redis-dev.ammienugu.online
    type        = "A"
    ttl         = 1
    records      = [aws_instance.redis.private_ip]
    allow_overwrite = true

}

resource "aws_route53_record" "rabbitmq" {
    zone_id     = var.zone_id
    name        = "rabbitmq-${var.environment}.${var.domain_name}" #rabbitmq-dev.ammienugu.online
    type        = "A"
    ttl         = 1
    records      = [aws_instance.rabbitmq.private_ip]
    allow_overwrite = true

}

resource "aws_route53_record" "mysql" {
    zone_id     = var.zone_id
    name        = "mysql-${var.environment}.${var.domain_name}" #mysql-dev.ammienugu.online
    type        = "A"
    ttl         = 1
    records      = [aws_instance.mysql.private_ip]
    allow_overwrite = true

}