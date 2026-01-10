variable "vm_type" {
  type        = list(string)
  default     = ["t2.micro"]
  description = "List of AWS EC2 instance types to use for virtual machines"
}
