output "dns_validation" {
  value = aws_acm_certificate.web_certificate.domain_validation_options
}

output "alb_dns_name" {
  value       = aws_lb.web_alb.dns_name
  description = "DNS name of the Load Balancer"
}

output "instances_info" {
  value = {
    asg = aws_autoscaling_group.web_asg.name
  }
}
