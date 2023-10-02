resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "main" {
  count                   = length(var.subnet_cidrs)
  cidr_block              = var.subnet_cidrs[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, count.index)
  tags = {
    Name = "${var.vpc_name}-subnet-${count.index}"
  }
}

resource "aws_security_group" "ecs_tasks" {
  vpc_id = aws_vpc.main.id
  name   = "ecs-tasks-sg"
}

resource "aws_security_group_rule" "ecs_tasks_ingress" {
  security_group_id = aws_security_group.ecs_tasks.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-gateway"
  }
}

# Create a Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main-route-table"
  }
}

# Associate the Route Table with your Subnet
resource "aws_route_table_association" "main" {
  count = length(aws_subnet.main)
  
  subnet_id      = aws_subnet.main[count.index].id
  route_table_id = aws_route_table.main.id
}
