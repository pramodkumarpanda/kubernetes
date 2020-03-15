resource "aws_vpc" "vpc1" {
  cidr_block       = "10.20.30.0/26"
  tags = {
    Name = "myvpc"
  }
}
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.20.30.0/27"
  
  map_public_ip_on_launch = true

  tags = {
    Name = "pulic-subnet"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.20.30.32/27"

  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "myigw"
  }
}


resource "aws_route_table" "myrtpub" {
  vpc_id = aws_vpc.vpc1.id
     
  
  tags = {
    Name = "mypublicrt"
  }
}


resource "aws_route_table_association" "mysubconn" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.myrtpub.id
}

resource "aws_route" "routerules" {
  route_table_id            = aws_route_table.myrtpub.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.myigw.id
}

resource "aws_eip" "eip" {
  vpc      = true
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet1.id
}


resource "aws_route_table" "myrtprivate" {
  vpc_id = aws_vpc.vpc1.id


  tags = {
    Name = "myprivrt"
  }
}


resource "aws_route_table_association" "mysubconn2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.myrtprivate.id
}



resource "aws_route" "routerulesnat" {
  route_table_id            = aws_route_table.myrtprivate.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.gw.id
}
