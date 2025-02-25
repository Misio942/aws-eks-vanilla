module "gitlab_oidc" {
  source  = "terraform-module/gitlab-oidc-provider/aws"
  version = "~> 1"
  role_name = format("%s-gitlab-oidc", var.project_name)
  create_oidc_provider = true
  create_oidc_role     = true

  tags = {
    oidc = "gitlab"
  }

  #gitlab_project_paths      = ["gitlab.com:telecom-argentina"]
  oidc_role_attach_policies = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]
}