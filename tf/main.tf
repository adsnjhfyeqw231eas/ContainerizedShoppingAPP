provider "aws" {
  access_key = "#########"
  secret_key = "############"
  region     = "us-east-1"
}

# Create Auto Scaling Group
resource "aws_autoscaling_group" "Demo-ASG-tf" {
  name                 = "Demo-ASG-tf"
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  force_delete         = true
  depends_on           = [aws_lb.ALB-tf]
  target_group_arns    = ["${aws_lb_target_group.TG-tf.arn}"]
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.name
  #vpc_zone_identifier  = ["${aws_subnet.prv_sub1.id}", "${aws_subnet.prv_sub2.id}"]
  vpc_zone_identifier = ["subnet-0a6a032cdb8ce3970", "subnet-0738ebf0c0eb33a64", "subnet-0c6789f5aedb09492"]

  tag {
    key                 = "Name"
    value               = "Demo-ASG-tf"
    propagate_at_launch = true
  }
}

# Create Target group

resource "aws_lb_target_group" "TG-tf" {
  name = "Demo-TargetGroup-tf"
  #depends_on = [aws_vpc.main]
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-012969b036248563e"
  health_check {
    interval = 70
    #path                = "/index.html"
    path                = "/"
    port                = 80
    healthy_threshold   = 10
    unhealthy_threshold = 10
    timeout             = 60
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}


# Create ALB

resource "aws_lb" "ALB-tf" {
  name               = "Demo-ALG-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webserver_sg.id]
  subnets            = ["subnet-0a6a032cdb8ce3970", "subnet-0738ebf0c0eb33a64", "subnet-0c6789f5aedb09492"]

  tags = {
    name    = "Demo-AppLoadBalancer-tf"
    Project = "demo-app"
  }
}

# Create ALB Listener 

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ALB-tf.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG-tf.arn
  }
}


resource "aws_security_group" "webserver_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH traffic via Terraform"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


#Create Launch config

resource "aws_launch_configuration" "webserver-launch-config" {
  name_prefix     = "webserver-launch-config"
  image_id        = "ami-0261755bbcb8c4a84"
  instance_type   = "t2.micro"
  key_name        = "tfans"
  security_groups = ["${aws_security_group.webserver_sg.id}"]

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    encrypted   = true
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = 10
    encrypted   = true
  }


  lifecycle {
    create_before_destroy = true
  }
  user_data = file("user-data.sh")
}

