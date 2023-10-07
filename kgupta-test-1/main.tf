module "k8s_cluster" {
  source = "../new"

  aws_region = var.aws_region

  cluster_name = var.cluster_name
  cluster_version = var.cluster_version

  env             = var.env
  owner           = var.owner

  vpc_id                = var.vpc_id
  vpc_subnets_private   = var.vpc_subnets_private
  vpc_subnets_public    = var.vpc_subnets_public
  whitelist_cidr_blocks = var.whitelist_cidr_blocks

  addtl_map_role_list = var.addtl_map_role_list

  iam_trust_service_account_arn_map             = var.iam_trust_service_account_arn_map
  iam_policy_service_account_allow_resource_map = var.iam_policy_service_account_allow_resource_map

  managed_node_groups = {
    for key, node in var.node_config_map :
    key => {
      node_group_name        = node.node_group_name
      create_launch_template = true
      launch_template_os     = "amazonlinux2eks"

      enable_metadata_options = node.enable_metadata_options

      # Node Group compute Configuration
      capacity_type  = node.capacity_type
      ami_type       = "AL2_x86_64" # Uses AWS optimized AMI type; for custom AMI set to "CUSTOM"
      instance_types = node.instance_types

      # Node Group scaling configuration
      desired_size = node.min_size
      min_size     = node.min_size
      max_size     = node.max_size

      # This is so cluster autoscaler can identify which node (using ASGs tags) to scale-down to zero nodes
      additional_tags = {
        ExtraTag                                                                       = "${node.instance_types[0]}-${node.node_group_name}"
        "k8s.io/cluster-autoscaler/node-template/label/eks.amazonaws.com/capacityType" = node.capacity_type
        "k8s.io/cluster-autoscaler/node-template/label/eks/node_group_name"            = node.node_group_name
        "kubernetes.io/os"                                                             = "linux"
      }
    }
  }
}
