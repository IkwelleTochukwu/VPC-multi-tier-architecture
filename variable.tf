variable "aws_region" {
  description = "region of deployment"
  type        = string
  default     = "us-west-1"
}



variable "cidrblock-vpc-1" {
  description = "cidr block for vpc-1"
  type        = string
  default     = "20.10.0.0/16"
}


variable "cidrblock-vpc-2" {
  description = "cidr block for vpc-2"
  type        = string
  default     = "20.20.0.0/16"
}

variable "resource-tags-vpc-1" {
  description = "name of my resources in vpc-1"
  type        = map(string)
  default = {
    "project" = "devs"
  }
}

variable "resource-tags-vpc-2" {
  description = "name of my resources in vpc-2"
  type        = map(string)
  default = {
    "project" = "prods"
  }
}

variable "cidrblock-vpc-1-pub" {
  description = "cidr block for the public subnet in vpc-1"
  type        = string
  default     = "20.10.1.0/24"
}

variable "cidrblock-vpc-2-pub" {
  description = "cidr block for the public subnet in vpc-2"
  type        = string
  default     = "20.20.10.0/24"
}

variable "cidr_block-vpc-1-priv-1a" {
  description = "cidr block for the first private subnet"
  type        = string
  default     = "20.10.10.0/24"
}

variable "cidr_block-vpc-2-priv" {
  description = "cidr block for the private subnet in vpc-2"
  type        = string
  default     = "20.20.20.0/24"
}

variable "cidr_block-vpc-1-priv-1b" {
  description = "cidr block for the second private subnet"
  type        = string
  default     = "20.10.20.0/24"
}

variable "cidr_block-vpc-1-priv-1c" {
  description = "cidr block for the third private subnet"
  type        = string
  default     = "20.10.30.0/24"
}

/*variable "publickey-A" {
  description = "publickey for the server"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5BDHxhN6mpW8bso2KJWYYwWLReBjvpBcmgsNlur1dc tochukwu ikwelle@LAPTOP-6CTH97GB"

}*/

variable "keyname_server" {
  description = "keyname for publickey"
  type        = string
  default     = "projectkey1"
}

variable "server-ami-devs" {
  description = "image for the server in vpc-1"
  type        = string
  default     = "ami-085284d24fe829cd0"
}

variable "instance-type-devs" {
  description = "hardware type for public server in vpc-1"
  type        = string
  default     = "t2.micro"
}

variable "rootvolumesize-devs" {
  description = "root volume size for devs public server"
  type        = number
  default     = 10
}

variable "server-ami-prods" {
  description = "image for the server in vpc-1"
  type        = string
  default     = "ami-085284d24fe829cd0"
}

variable "instance-type-prods" {
  description = "hardware type for server in vpc-1"
  type        = string
  default     = "t2.micro"
}

variable "rootvolumesize-prods" {
  description = "root volume size for prods server"
  type        = number
  default     = 8
}

