nomad {
  address = "http://localhost:4646"
}

telemetry {
  prometheus_metrics = true
  disable_hostname   = true
}

apm "prometheus" {
  driver = "prometheus"
  config = {
    # FIXME
    address = "http://192.168.0.100:9090"
  }
}

strategy "target-value" {
  driver = "target-value"
}
