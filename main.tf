resource "aws_vpc" "mahesh-vpc" {
  cidr_block       = var.vpc-cidr

  tags = {
    Name = "Mahesh Vpc"
    Owner = "Mahesh Jindal"
    purpose = "Training"
  }
}

resource "aws_subnet" "mahesh-pub-subnets" {
  vpc_id = aws_vpc.prod-vpc.id
  count = length(var.azs)
  cidr_block = element(var.mahesh-pub-subnets , count.index)
  availability_zone = element(var.azs , count.index)

  tags = {
    Name = "Mahesh Production Public Subnet"
    Owner = "Mahesh Jindal"
    purpose = "Training"
  }
}

resource "aws_subnet" "mahesh-pvt-subnets" {
  vpc_id = aws_vpc.prod-vpc.id
  count = length(var.azs)
  cidr_block = element(var.mahesh-pvt-subnets , count.index)
  availability_zone = element(var.azs , count.index)

  tags = {
    Name = "Mahesh Production Private Subnet"
    Owner = "Mahesh Jindal"
    purpose = "Training"
  }
}

#IGW
resource "aws_internet_gateway" "mahesh-igw" {
  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    Name = "Mahesh Internet gateway"
    Owner = "Mahesh Jindal"
    purpose = "Training"
  }
}

#route table for public subnet
resource "aws_route_table" "mahesh-pub-rtable" {
  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    Name = "Mahesh Route Table"
    Owner = "Mahesh Jindal"
    purpose = "Training"
  }
}

#route table association public subnets using count
resource "aws_route_table_association" "mahesh-pub-subnet-association" {
  count          = length(var.mahesh-pub-subnets)
  subnet_id      = element(aws_subnet.mahesh-pub-subnets.*.id , count.index)
  route_table_id = aws_route_table.prod-public-rtable.id
}


#add routes to public-rtable just for testing of for_each loop
resource "aws_route" "ner-subnets-pub-rtable" {
  route_table_id            = aws_route_table.prod-public-rtable.id
  gateway_id                = aws_internet_gateway.prod-igw.id
  for_each                  = toset(var.public-subnets)
  destination_cidr_block = each.value
}

#backend
resource "aws_s3_bucket" "s3_bucket_instance"{
    for_each=var.s3_bucket_tag
    bucket=each.value["name"]
    tags={
        Name=each.value["name"]
        Owner=each.value["owner"]
        Purpose=each.value["purpose"]
    }
}