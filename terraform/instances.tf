resource "aws_instance" "locust" {
  ami = "${var.ami_id}"
  subnet_id = "${var.subnet_id}"
  instance_type = "t2.small"
  key_name = "${var.key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.locust.id}"
  ]
  associate_public_ip_address = true
  user_data = "${template_file.locust.rendered}"
  tags {
    Name = "locust"
  }
}

resource "template_file" "locust" {
  filename = "${path.module}/locust.sh"
  vars {
    docker_username = "${var.docker_username}"
    docker_password = "${var.docker_password}"
  }
}

resource "aws_instance" "wls_api" {
  ami = "${var.ami_id}"
  subnet_id = "${var.subnet_id}"
  instance_type = "t2.small"
  key_name = "${var.key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.wls_api.id}"
  ]
  associate_public_ip_address = true
  user_data = "${template_file.wls_api.rendered}"
  tags {
    Name = "wls_api"
  }
}

resource "template_file" "wls_api" {
  filename = "${path.module}/wls_api.sh"
  vars {
    docker_username = "${var.docker_username}"
    docker_password = "${var.docker_password}"
  }
}

resource "aws_instance" "stub" {
  ami = "${var.ami_id}"
  subnet_id = "${var.subnet_id}"
  instance_type = "t2.small"
  key_name = "${var.key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.stub.id}"
  ]
  associate_public_ip_address = true
  user_data = "${template_file.stub.rendered}"
  tags {
    Name = "stub"
  }
}

resource "template_file" "stub" {
  filename = "${path.module}/stub.sh"
  vars {
    docker_username = "${var.docker_username}"
    docker_password = "${var.docker_password}"
  }
}
