variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "sg_names" {
    type = list
    default = [
        "mongodb", "redis", "mysql", "rabbitmq",
        "catalogue", "user", "shipping", "payment", "cart",
        "backend_alb",
        "frontend",
        "frontend_alb",
        "bastion"
    ]
}