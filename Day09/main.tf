resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow HTTP and HTTPS inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
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


resource "aws_instance" "vm_example" {
  instance_type = length(var.vm_type) > 0 ? var.vm_type[0] : "t2.micro"
  ami           = "ami-0912f71e06545ad88"

  security_groups = [aws_security_group.allow_web.name]

  region = "ap-south-1"

  lifecycle {
    replace_triggered_by = [aws_security_group.allow_web]
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "example-bucket-unique-gulistane-name-12345"

  lifecycle {
    # Precondition: ensure at least one VM type is specified
    precondition {
      condition     = length(var.vm_type) > 0
      error_message = "At least one VM type must be specified in var.vm_type."
    }

    # Postcondition: validate the bucket was created with the correct name
    postcondition {
      condition     = self.bucket == "example-bucket-unique-gulistane-name-12345"
      error_message = "The S3 bucket name does not match the expected name."
    }
  }
}
