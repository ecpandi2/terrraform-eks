# Terraform Remote State Datasource
data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "../AWS-EKS-Cluster-Basics/terraform.tfstate"
   }
}