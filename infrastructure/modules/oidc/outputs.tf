output "jlcrc2_github_oidc_backend_deploy_role_arn" {
    description = "ARN of the Github OIDC backend deploy role"
    value = aws_iam_role.github_oidc_backend_deploy_role.arn
}