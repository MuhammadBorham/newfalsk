terraform {
  backend "s3" {
    bucket  = "tf-state-bucket007" # Replace with your bucket name
    key     = "terraform.tfstate"  # Path to store the state file
    region  = "eu-west-1"          # AWS region
    encrypt = true                 # Enable encryption
  }
}
