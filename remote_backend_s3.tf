terraform {
  backend "s3" {
    bucket = "tf-ansibe-iac-remote-state-bucket"
    key    = "iac-demo-project/terraform.tfstate"
    region = "us-east-2"
  }
}