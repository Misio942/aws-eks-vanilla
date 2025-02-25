resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  # version    = "0.14.2"
  repository = "https://external-secrets.github.io/kubernetes-external-secrets"
  chart      = "kubernetes-external-secrets"
  namespace  = "external-secrets"

  set {
    name  = "createCRDs"
    value = "true"
  }

  set {
    name  = "secretStoreCluster.create"
    value = "true"
  }

  set {
    name  = "secretStoreCluster.name"
    value = "sandbox-secret-store"
  }

  set {
    name  = "secretStoreCluster.type"
    value = "kubernetes"
  }

  set {
    name  = "secretStoreCluster.config.namespace"
    value = "external-secrets"
  }


  depends_on = [
    aws_eks_cluster.main,
    aws_eks_node_group.spot
  ]
}

module "external_secrets_irsa_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = format("%s-external-secrets-irsa", var.project_name)

  attach_external_secrets_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.gitlab_oidc.oidc_provider_arn
      namespace_service_accounts = ["external-secrets:external-secrets-kubernetes-external-secrets"]
    }
  }

  # depends_on = [
  #   helm_release.external_secrets
  # ]
}