output "cluster_endpoint" {
    description = "Cluster endpoint"
    value = module.eks.cluster_endpoint
}

output "cluster_cert" {
    description = "Cluster Cert"
    value = module.eks.cluster_certificate_authority_data
}

output "cluster_id" {
    description = "Cluster ID"
    value = module.eks.cluster_id
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks.cluster_arn
}

##output "cluster_name" {
##  description = "The name of the EKS cluster"
##  value       = module.eks.cluster_name
##}


