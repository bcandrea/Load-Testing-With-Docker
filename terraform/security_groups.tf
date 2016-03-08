resource "aws_security_group" "locust" {
  name = "locust"
  description = "locust"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "locust"
  }

  ingress {
    self = true
    from_port = 8089
    to_port = 8089
    protocol = "tcp"
    cidr_blocks = [
      "${var.authorised_cidr_block}"
    ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "wls_api" {
  name = "wls_api"
  description = "wls_api"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "wls_api"
  }

  ingress {
    self = true
    from_port = 9000
    to_port = 9000
    protocol = "tcp"
    cidr_blocks = [
      "${var.authorised_cidr_block}"
    ]
    security_groups = [
      "${aws_security_group.locust.id}"
    ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "stub" {
  name = "stub"
  description = "stub"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "stub"
  }

  ingress {
    self = true
    from_port = 9050
    to_port = 9050
    protocol = "tcp"
    cidr_blocks = [
      "${var.authorised_cidr_block}"
    ]
    security_groups = [
      "${aws_security_group.wls_api.id}"
    ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
