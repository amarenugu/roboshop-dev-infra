variable "environment" {
    default = "dev"
}

variable "zone_id" {
    default = "Z07085123QJECUXR7X13I"
}

variable "domain_name" {
    default = "ammienugu.online"
}

variable "components" {
    default = {
        catalogue = {
           app_version = "v3" 
           
        }
    }
}