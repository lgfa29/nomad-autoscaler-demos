resource "aws_elb" "servers" {
  name               = "${var.stack_name}-servers"
  instances          = var.server_ids
  availability_zones = var.availability_zones
  security_groups    = [aws_security_group.servers_lb.id]
  internal           = false
  idle_timeout       = 360

  # Nomad
  listener {
    instance_port     = 4646
    instance_protocol = "http"
    lb_port           = 4646
    lb_protocol       = "http"
  }

  # Consul
  listener {
    instance_port     = 8500
    instance_protocol = "http"
    lb_port           = 8500
    lb_protocol       = "http"
  }

  tags = {
    OwnerName  = var.owner_name
    OwnerEmail = var.owner_email
  }
}

resource "aws_elb" "clients" {
  count = length(var.client_load_balancers)

  name               = "${var.stack_name}-${var.client_load_balancers[count.index].name}-clients"
  availability_zones = var.availability_zones
  security_groups    = [aws_security_group.clients[count.index].id]
  internal           = false

  dynamic "listener" {
    for_each = var.client_load_balancers[count.index].listeners

    content {
      instance_port     = listener.value["port"]
      instance_protocol = listener.value["protocol"]
      lb_port           = listener.value["port"]
      lb_protocol       = listener.value["protocol"]
    }
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 3
    target              = "${var.client_load_balancers[count.index].listeners[0]["protocol"]}:${var.client_load_balancers[count.index].listeners[0]["port"]}"
  }

  tags = {
    OwnerName  = var.owner_name
    OwnerEmail = var.owner_email
  }
}
