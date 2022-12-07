terraform {
  backend "s3" {
    bucket = "maheshsprintbucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}