# resource "kubernetes_config_map" "aws-auth" {
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }

#   data = {
#     mapRoles = <<YAML
# - rolearn: ${aws_iam_role.eks_nodes_role.arn}
#   username: system:node:{{EC2PrivateDNSName}}
#   groups:
#     - system:bootstrappers
#     - system:nodes
#     - system:node-proxier
# # Agregá este bloque si usás un role *diferente* para nodos Karpenter:
# - rolearn: ${aws_iam_role.karpenter.arn}
#   username: system:node:{{EC2PrivateDNSName}}
#   groups:
#     - system:bootstrappers
#     - system:nodes
#     - system:node-proxier
# # Si usás Fargate:
# - rolearn: ${aws_iam_role.fargate.arn}
#   username: system:node:{{SessionName}}
#   groups:
#     - system:bootstrappers
#     - system:nodes
#     - system:node-proxier
# YAML
#   }

#   depends_on = [
#     aws_eks_cluster.main
#   ]
# }