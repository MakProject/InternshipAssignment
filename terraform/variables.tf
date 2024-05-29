variable "aws_region" {
  description = "The AWS region to deploy in"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "Instance Type"
  default     = "t2.medium"
}

variable "ami_id" {
  description = "AMI ID"
  default     = "ami-0f58b397bc5c1f2e8"  
}

variable "key_name" {
  description = "SERVER KEY"
  default     = "server"  
}
