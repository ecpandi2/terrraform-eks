# Terraform Remote State Datasource
/*
data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "../../08-AWS-EKS-Cluster-Basics/01-ekscluster-terraform-manifests/terraform.tfstate"
   }
}
*/
# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
<<<<<<< HEAD
<<<<<<< HEAD
    path = "../AWS-EKS-Cluster-Basics/terraform.tfstate"
=======
    bucket = "terraform-pandiyan"
=======
    bucket = "terraform-on-aws-eks"
>>>>>>> ecb99d767f40ca0e1b52475479c6729294619ee9
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1" 
>>>>>>> 79c44d4d21bde80bff30b5e9c35f5c61f7d61554
  }
}