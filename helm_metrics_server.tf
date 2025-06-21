// Not use when provisioner fargate

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  namespace  = "kube-system"

  wait    = false
  version = "7.2.16"

  # set {
  #   name  = "image.repository"
  #   value = "registry.k8s.io/metrics-server/metrics-server"
  # }
  # set {
  #   name  = "image.tag"
  #   value = "v0.7.0"
  # }

  set {
    name  = "apiService.create"
    value = "true"
  }

  # set {
  #   name  = "serviceAccount.automountServiceAccountToken"
  #   value = "true"
  # }

  # set {
  #   name  = "args[0]"
  #   value = "--cert-dir=/tmp"
  # }
  # set {
  #   name  = "args[1]"
  #   value = "--secure-port=8443"
  # }
  # set {
  #   name  = "args[2]"
  #   value = "--kubelet-insecure-tls"
  # }
  # set {
  #   name  = "args[3]"
  #   value = "kubelet-preferred-address-types=InternalIP"
  # }

  # # Cambiar el puerto expuesto del contenedor a 8443 para evitar necesidad de root
  # set {
  #   name  = "containerPorts.https"
  #   value = "8443"
  # }

  # # # Opcional: cambiar también el Service para exponer 8443
  # set {
  #   name  = "service.ports.https"
  #   value = "8443"
  # }

  depends_on = [
    aws_eks_cluster.main,
    aws_eks_node_group.main
    #aws_eks_fargate_profile.kube_system
  ]
}
