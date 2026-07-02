# ===========================================================================
# Terraform local values that can be used across the Terraform configuration.
# ===============================================================================
#  project name: lowercase, hyphenated, and includes environment
locals {
  formatted_project_name = format("%s-%s", lower(var.project_name), lower(var.environment))
}
#  merged tags: combines general tags with VPC-specific tags
locals {
  merged_tags = merge(var.tags, var.vpc-tags)
}
# S3 bucket names: max 63 chars, lowercase, no spaces or special chars
locals {
  formatted_bucket_name = substr(lower(replace(var.project_name, " ", "-")), 0, 63)
}
# Security group ports: split comma-separated string into list, then join with commas for SG rules
locals {
  sg_rules = [
    for port in split(",", var.sg_ports) : {
      name        = "allow-port-${port}"
      description = "Allow inbound traffic on port ${port}"
      from_port   = tonumber(port)
      to_port     = tonumber(port)
      protocol    = "tcp"
    }
  ]
}

locals {
  # Split comma-separated ports into list
  port_list = split(",", var.allowed_ports)

  # Create security group rules data structure
  sg_rules = [for port in local.port_list : {
    name        = "port-${port}"
    port        = port
    description = "Allow traffic on port ${port}"
  }]

  # Format for documentation: "port-80-port-443-port-8080-port-3306"
  formatted_ports = join("-", [for port in local.port_list : "port-${port}"])
}


locals {
  # Lookup instance size based on environment, with fallback
  instance_size = lookup(var.instance_sizes, var.environment, "t2.micro")
}

locals {
  # Read and parse JSON configuration file
  config_file_exists = fileexists("./config.json")
  
  config_data = local.config_file_exists ? jsondecode(file("./config.json")) : {
    database = {
      host     = "localhost"
      port     = 5432
      username = "default"
    }
  }
}