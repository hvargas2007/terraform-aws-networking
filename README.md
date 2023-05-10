# Despliegue de infraestructura base para las cuentas de AWS ITAU

## Recursos desplegados en este manifiesto:  

### AWS Account:
- VPC
- 2 subnet privadas para APP (AZ A y B)
- 2 Subnet privadas para DB  (AZ A y B)
- 1 route table para las subnet
- VPC flow Log
- CLoudWatch
- IAM ROLE para CloudWatch y VPC Flow Log

## Solucion diagrama:

  ![App Screenshot](diagrama/diagrama_base.png)

## Probado con: 

| Ambiente         | aplicacion | Version |
| ----------------- | ---------- | ------- |
| WSL2 Ubuntu 20.04 | Terraform  | v1.4.6  |
| WSL2 Ubuntu 20.04 | aws-cli    | v2.7.9 |

## Procedimientos de implementación:  

sEn el archivo main.tf debe hacerse referencia al source del repositorio que vayamos a desplegar y colocoar las variables utilizadas para el despliegue por ejemplo:

Cree un .tfvar con un contenido como el siguiente: 

```bash
aws_profile       = "" profile creado para desplegar en la cuenta
aws_region        = "" Region en donde se desplegara
vpc_cidr          = "" CIDR de la VPC
logs_retention    = "" Cantidad de dia de retencion de LOG
name_prefix       = "" Nombre referecial para los recursos
PublicSubnet = [
{
    name    = "" Nombre de la Subnet A
    az      = "" Az de la subnet A
    cidr    = "" CIDR de la subnet A
},
{
    name    = "" Nombre de la Subnet B
    az      = "" Az de la subnet B
    cidr    = "" CIDR de la subnet B
}
]
PrivateSubnet = [
{
    name    = "" Nombre de la Subnet A
    az      = "" Az de la subnet A
    cidr    = "" CIDR de la subnet A
},
{
    name    = "" Nombre de la Subnet B
    az      = "" Az de la subnet B
    cidr    = "" CIDR de la subnet B
}
]
project-tags = {
    DeployBy   = "", Nombre de que realiza el deploy
    Enviroment = "" Ambiente
}

```

Clonar el proyecto 

```bash
  git clone https://github.com/cloudhesive/terraform_IaC.git
```
Ir al directorio del proyecto 

```bash
  cd vpc
```

Ubicado en el directorio donde se encuentra en manifiesto de terraform, haga un "aws configure" para iniciar sesión en la cuenta de aws y un "terraform init" para descargar los módulos necesarios e iniciar el backend.
 
```bash
aws configure
terraform init
```

## Procedimientos de implementación:

Ubicado en el directorio donde se encuentra en manifiesto de terraform, realice los cambios necesarios en el archivo variables.tf y ejecute los manifiestos: 

```bash
terraform fmt      = para darle formato a los archivos
terraform validate = validamos que no tengamos alguna inconsistencia en los recursos
terraform apply    = realizamos ya el despliegue de los recursos
terraform destroy  = destruimos todo lo desplegamos en este manisfiesto
```
## Autor:
Hermes Vargas - Hermes.vargas@cloudhesive.com