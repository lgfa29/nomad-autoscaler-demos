# Horizontal Application Scaling Demo

Instructions available at [HashiCorp Learn][learn_horizontal_app_scaling].

## MacOS arm64 Local

0. Check that Docker Desktop is set to `gRPC FUSE` under `Settings -> General -> Choose file sharing implementation for your containers`.
1. Download the [latest version of Nomad](https://releases.hashicorp.com/nomad/1.5.3/nomad_1.5.3_darwin_arm64.zip).
2. Start Nomad agent.
    ```shell-session
    $ sudo mkdir -p /opt/nomad
    $ sudo nomad agent -config ./files/nomad.hcl
    ```
3. Fix path under `#FIXME` in `./jobs/grafana.nomad`.
4. Run jobs.
    ```shell-session
    $ nomad run ./jobs/traefik.nomad
    $ nomad run ./jobs/prometheus.nomad
    $ nomad run ./jobs/grafana.nomad
    $ nomad run ./jobs/webapp.nomad
    ```
5. Access dashboard at http://<YOUR IP>:3000/d/8QlvShyZz/nomad-autoscaler-demo?orgId=1&refresh=5s
6. Fix your IP under `#FIXME` in `./files/autoscaler.hcl`.
7. Run autoscaler agent locally.
    ```shell-session
    $ nomad-autoscaler agent -config ./files/autoscaler.hcl
    ```
8. Follow the tutorial from
   https://developer.hashicorp.com/nomad/tutorials/autoscaler/autoscaler-vagrant-demo#enable-the-scaling-policy-and-scale-down.

[learn_horizontal_app_scaling]: https://learn.hashicorp.com/tutorials/nomad/autoscaler-vagrant-demo?in=nomad/autoscaler
