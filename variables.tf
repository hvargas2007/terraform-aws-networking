variable "aws_profile" {
  description = "[REQUERIDO] El perfil de AWS que se usará para implementar los recursos."
  type        = string
}

variable "aws_region" {
  description = "[REQUERIDO] La región de AWS en la que se implementarán los recursos."
  type        = string
}

variable "vpc_cidr" {
  description = "[REQUERIDO] El bloque CIDR, en formato REQUERIDO '0.0.0.0/0'."
  type        = string
}

variable "logs_retention" {
  description = "[REQUERIDO] El número de días durante los cuales se retendrán los eventos de registro en CloudWatch."
  type        = number
}

variable "name_prefix" {
  description = "[REQUERIDO] Prefijo que se usará para los nombres de los recursos."
  type        = string
}

variable "transit_gateway_id" {
  description = "[REQUERIDO] ID del transit gateway para adjuntar a la VPC."
  type        = string
}

variable "PrivateSubnet" {
  description = "[REQUERIDO] Lista de mapas con los valores clave para crear el CIDR mediante la función cidrsubnets, además del nombre y el número de índice para la zona de disponibilidad."
  type = list(object({
    name = string
    az   = string
    cidr = string
  }))
}

variable "PrivateSubnetDb" {
  description = "[REQUERIDO] Lista de mapas con los valores clave para crear el CIDR mediante la función cidrsubnets, además del nombre y el número de índice para la zona de disponibilidad."
  type = list(object({
    name = string
    az   = string
    cidr = string
  }))
}

variable "dns_phz" {
  description = "[REQUERIDO] Nombre de DNS privado en la cuenta."
  type        = string
}

variable "project-tags" {
  type = map(string)
  default = {
  }
}


