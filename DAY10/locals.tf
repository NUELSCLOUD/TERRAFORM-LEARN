locals {
   # Transform "Project ALPHA Resource" to "project-alpha-resource"
   formatted_project_name = lower(replace(var.project_name, " ", "-"))
}

locals {
  # Merge default tags with environment-specific tags
  merged_tags = merge(var.default_tags, var.environment_tags)
}

locals {
  # S3 bucket names: max 63 chars, lowercase, no spaces or special chars
  formatted_bucket_name = replace(
    replace(
      lower(substr(var.bucket_name, 0, 63)),
      " ", ""
    ),
    "!", ""
  )
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