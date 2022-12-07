variable "region" {
  default = "ap-south-1"
}

variable "vpc-cidr" {
  default = "10.22.0.0/16"
}

variable "azs" {
  type = list
  default = ["ap-south-1a" , "ap-south-1b"]
}

variable "mahesh-pvt-subnets" {
  type = list
  default = ["10.0.8.0/24" , "10.209.0/24"]
}

variable "mahesh-pub-subnets" {
  type = list
  default = ["10.0.16.0/24" , "10.0.17.0/24"]
}

#for_each loop testing
variable "public-subnets" {
  type = list
  default = ["21.21.21.0/24"  , "22.22.22.0/24", "23.23.23.0/24", "24.24.24.0/24"]
}

variable "s3_bucket_tag"{
    type=map(any)
}