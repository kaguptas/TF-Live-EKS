variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Name of cluster owner"
  type        = string
  default     = "kgupta@snaplogic.com"
}

variable "cluster_version" {
  description = "K8s version for cluster"
  type        = string
  default     = "1.25"
}

variable "cluster_name" {
  description = "Cluster Name"
  type        = string
  default     = "kgupta-test-1"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-0f69f5bf71d85b552"
}

variable "vpc_subnets_private" {
  description = "VPC subnets"
  type        = list(string)
  default     = ["subnet-0ce53f4804f311c6d", "subnet-035af8c5841ac1691", "subnet-037d1a4da5d40f740"]
}

variable "vpc_subnets_public" {
  description = "VPC subnets"
  type        = list(string)
  default     = []
}

variable "whitelist_cidr_blocks" {
  description = "CIDR blocks to whitelist for SG rules"
  type        = list(string)
  default     = ["172.27.0.0/16"]
}

variable "iam_trust_service_account_arn_map" {
  description = "Service accounts to insert in trust policy"
  type        = map(list(string))
  default = {
    dev-canv2   = ["system:serviceaccount:canv2-platform:canv2-platform-slmetrics-sa"]
    dev-perfv2  = ["system:serviceaccount:perfv2-platform:perfv2-platform-slmetrics-sa"]
    dev-stagev2 = ["system:serviceaccount:stagev2-platform:stagev2-platform-slmetrics-sa"]
    dev-snapv2  = ["system:serviceaccount:snapv2-platform:snapv2-platform-slmetrics-sa"]
  }
}

variable "iam_policy_service_account_allow_resource_map" {
  description = "Resources to allow service account access to"
  type        = map(list(string))
  default = {
    dev-canv2 = [
      "arn:aws:kms:us-west-2:694702677705:key/a3c239ff-96fe-4177-bcbb-71c44612c128",
      "arn:aws:secretsmanager:us-west-2:694702677705:secret:/canv2/*",
      "arn:aws:ssm:*:*:parameter/canv2/*"
    ]
    dev-perfv2 = [
      "arn:aws:kms:us-west-2:694702677705:key/a3c239ff-96fe-4177-bcbb-71c44612c128",
      "arn:aws:secretsmanager:us-west-2:694702677705:secret:/perfv2/*",
      "arn:aws:ssm:*:*:parameter/perfv2/*"
    ]
    dev-stagev2 = [
      "arn:aws:kms:us-west-2:694702677705:key/a3c239ff-96fe-4177-bcbb-71c44612c128",
      "arn:aws:secretsmanager:us-west-2:694702677705:secret:/stagev2/*",
      "arn:aws:ssm:*:*:parameter/stagev2/*"
    ]
    dev-snapv2 = [
      "arn:aws:kms:us-west-2:694702677705:key/a3c239ff-96fe-4177-bcbb-71c44612c128",
      "arn:aws:secretsmanager:us-west-2:694702677705:secret:/snapv2/*",
      "arn:aws:ssm:*:*:parameter/snapv2/*"
    ]
  }
}

variable "addtl_map_role_list" {
  description = "Additional IAM roles to add to the aws-auth ConfigMap"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  # For local testing:
  default = [
    {
      rolearn  = "arn:aws:iam::694702677705:role/DevOps"
      username = "DevOps"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::694702677705:role/devqa"
      username = "devqa"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::694702677705:role/AWSReservedSSO_DevOps_3cf9f94ab2e35ed2"
      username = "SSODevOps"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::694702677705:role/AWSReservedSSO_devqa_a0fb114e7d394054"
      username = "SSOdevqa"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::694702677705:role/AWSReservedSSO_ReadOnly_db215d9ee53e236f"
      username = "SSOreadonly"
      groups   = ["view"]
    },
    {
      rolearn  = "arn:aws:iam::694702677705:role/AWSReservedSSO_Owner_852514fb1a0ee282"
      username = "SSOowner"
      groups   = ["system:masters"]
    }
  ]
}


variable "node_config_map" {
  description = "Map of node group configuration variables"
  type = map(object({
    node_group_name         = string
    capacity_type           = string
    instance_types          = list(string)
    min_size                = number
    max_size                = number
    enable_metadata_options = optional(bool, false)
  }))
  default = {
    ondemand_v2 = {
      node_group_name = "ondemand_v2",
      capacity_type   = "ON_DEMAND",
      instance_types  = ["m5.2xlarge"],
      min_size        = 2,
      max_size        = 2
    }
  }
}
