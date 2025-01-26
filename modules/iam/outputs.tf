output "role_name" {
  value = aws_iam_role.ec2_s3_access.name
}

output "policy_arn" {
  value = aws_iam_policy.s3_write_policy.arn
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_instance_profile.name
}
