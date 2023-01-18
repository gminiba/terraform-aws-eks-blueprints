# ---------------------------------------------------------------------------------------------------------------------
# MANAGED NODE GROUPS
# ---------------------------------------------------------------------------------------------------------------------

module "aws_eks_managed_node_groups" {
  source = "./modules/aws-eks-managed-node-groups"

  for_each = var.managed_node_groups

  managed_ng = each.value
  context    = local.node_group_context

  depends_on = [module.aws_eks.cluster_id, data.http.eks_cluster_readiness[0]]
}

# ---------------------------------------------------------------------------------------------------------------------
# SELF MANAGED NODE GROUPS
# ---------------------------------------------------------------------------------------------------------------------

module "aws_eks_self_managed_node_groups" {
  source = "./modules/aws-eks-self-managed-node-groups"

  for_each = var.self_managed_node_groups

  self_managed_ng = each.value
  context         = local.node_group_context

  depends_on = [module.aws_eks.cluster_id, data.http.eks_cluster_readiness[0]]
}

# ---------------------------------------------------------------------------------------------------------------------
# FARGATE PROFILES
# ---------------------------------------------------------------------------------------------------------------------

module "aws_eks_fargate_profiles" {
  source = "./modules/aws-eks-fargate-profiles"

  for_each = var.fargate_profiles

  fargate_profile = each.value
  context         = local.fargate_context

  depends_on = [module.aws_eks.cluster_id, data.http.eks_cluster_readiness[0]]
}
