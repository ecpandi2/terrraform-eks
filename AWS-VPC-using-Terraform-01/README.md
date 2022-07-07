# Design a 3 Tier AWS VPC with NAT Gateways using Terraform

## Step-01: Introduction
- Understand about Terraform Modules
- Create VPC using `Terraform Modules`
- Define `Input Variables` for VPC module and reference them in VPC Terraform Module
- Define `local values` and reference them in VPC Terraform Module
- Create `terraform.tfvars` to load variable values by default from this file
- Create `vpc.auto.tfvars` to load variable values by default from this file related to a VPC 
- Define `Output Values` for VPC

## Step-02: vpc-module - Hardcoded Model
### Step-02-01: How to make a decision of using the public Registry module?
1. Understand about [Terraform Registry and Modules](https://registry.terraform.io/)
2. We are going to use a [VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) from Terraform Public Registry
3. Understand about Authenticity of a module hosted on Public Terraform Registry with [HashiCorp Verified Tag](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
4. Review the download rate for that module
5. Review the latest versions and [release history](https://github.com/terraform-aws-modules/terraform-aws-vpc/releases) of that module
6. Review our feature needs when using that module and ensure if our need is satisfied use the module else use the standard terraform resource definition appraoch. 
7. Review module inputs, outputs and dependencies too. 
### Step-02-02: Create a VPC Module Terraform Configuration 
- versions.tf
- generic-variables.tf
- vpc.tf
- [Terraform AWS VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
```t
# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  # VPC Basic Details
  name = "vpc-dev"
  cidr = "10.0.0.0/16"   
  azs                 = ["us-east-1a", "us-east-1b"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]

  # Database Subnets
  create_database_subnet_group = true
  create_database_subnet_route_table= true
  database_subnets    = ["10.0.151.0/24", "10.0.152.0/24"]

  #create_database_nat_gateway_route = true
  #create_database_internet_gateway_route = true

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = true
  single_nat_gateway = true

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

  tags = {
    Owner = "Pandiyan"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }
}
```

## Step-03: Execute Terraform Commands
```t
# Working Folder
vpc-module

# Terraform Initialize
terraform init
Observation:
1. Verify if modules got downloaded to .terraform folder

# Terraform Validate
terraform validate

# Terraform plan
terraform plan

# Terraform Apply
terraform apply -auto-approve
Observation:
1) Verify VPC
2) Verify Subnets
3) Verify IGW
4) Verify Public Route for Public Subnets
5) Verify no public route for private subnets
6) Verify NAT Gateway and Elastic IP for NAT Gateway
7) Verify NAT Gateway route for Private Subnets
8) Verify no public route or no NAT Gateway route to Database Subnets
9) Verify Tags

# Terraform Destroy
terraform destroy -auto-approve

# Delete Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```
## Step-04: Version Constraints in Terraform with Modules
- [Terraform Version Constraints](https://www.terraform.io/docs/language/expressions/version-constraints.html)
- For modules locking to the exact version is recommended to ensure there will not be any major breakages in production
- When depending on third-party modules, require specific versions to ensure that updates only happen when convenient to you
- For modules maintained within your organization, specifying version ranges may be appropriate if semantic versioning is used consistently or if there is a well-defined release process that avoids unwanted updates.
- [Review and understand this carefully](https://www.terraform.io/docs/language/expressions/version-constraints.html#terraform-core-and-provider-versions)