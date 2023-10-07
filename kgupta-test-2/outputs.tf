output "cluster_name" {
  description = "EKS Cluster Name"
  value       = var.cluster_name
}

output "cluster_tags" {
  description = "Shared tags to attach"
  value       = module.k8s_cluster.tags
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.k8s_cluster.eks_cluster_endpoint
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.k8s_cluster.eks_cluster_id
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.k8s_cluster.eks_oidc_issuer_url
}

output "cluster_oidc_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
  value       = module.k8s_cluster.eks_oidc_provider_arn
}

output "sa_iam_role_arns" {
  description = "List of Service Account IAM role ARNs"
  value       = module.k8s_cluster.sa_iam_role_arns
}
