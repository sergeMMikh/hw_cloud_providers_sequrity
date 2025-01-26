variable "role_name" {
  description = "Name of the IAM Role"
  type        = string
  default     = "ec2-s3-access-role"
}

variable "policy_name" {
  description = "Name of the IAM Policy"
  type        = string
  default     = "ec2-s3-write-policy"
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  type        = string
}

variable "instance_profile_name" {
  description = "Name of the IAM Instance Profile"
  type        = string
}
