variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  default     = "your_key_pair_name"
}

variable "security_group_name" {
  description = "The name of the security group for the web server"
  default     = "web-server-sg"
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks to allow SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "http_cidr_blocks" {
  description = "CIDR blocks to allow HTTP access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "https_cidr_blocks" {
  description = "CIDR blocks to allow HTTPS access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "redirect_host_header_values" {
  description = "Host header values to apply the HTTP to HTTPS redirect condition"
  type        = list(string)
  default     = ["example.com"]
}
