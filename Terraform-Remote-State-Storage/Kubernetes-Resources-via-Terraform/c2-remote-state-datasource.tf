# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
<<<<<<< HEAD
    path = "../AWS-EKS-Cluster-Basics/terraform.tfstate"
=======
    bucket = "terraform-pandiyan"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1" 
>>>>>>> 79c44d4d21bde80bff30b5e9c35f5c61f7d61554
  }
}