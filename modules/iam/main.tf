# IAM Role
resource "aws_iam_role" "ec2_s3_access" {
  name = var.role_name

  # Политика доверия
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        # создает IAM роль
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          # кто имеет право использовать эту роль
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for S3 access создает IAM политику, которая определяет набор действий, разрешенных для роли
resource "aws_iam_policy" "s3_write_policy" {
  name        = var.policy_name
  description = "Allow EC2 instances to write files to S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          # загрузка объектов в S3 и управление их правами доступа
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        # Применяется к ресурсам внутри S3-бакета, который указывается в переменной
        # Resource = "${var.s3_bucket_arn}/*"
        Resource = "arn:aws:s3:::hw-smmikh-january-2025-store-bucket/*"
      }
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role = aws_iam_role.ec2_s3_access.name
  # ARN (Amazon Resource Name) IAM политики
  policy_arn = aws_iam_policy.s3_write_policy.arn
}

# IAM Instance Profile создает Instance Profile (профиль экземпляра), который может быть привязан к EC2-инстансам
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.ec2_s3_access.name
}
