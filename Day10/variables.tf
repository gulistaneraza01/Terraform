variable "bucket_name" {
  type = string
}


variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    env         = "dev"
    created_by  = "raza"
    project     = "image-processing"
    department  = "cloud"
    cost_center = "it-101"
  }
}


variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

