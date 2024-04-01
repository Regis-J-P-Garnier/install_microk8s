# Some Basic Scripts for Microk8s Management by Ansible

It's a hands-on work. Combination on a new tool, microk8s, and not used for a time Kubernetes and Ansible.  

## Facts

- I want to try a light & clean CI/CD pipeline on a small standalone server.
- I want to try the solution on various machines.
- I want to use existing Grafana, dns and other existing homelab services. 
- I work with existing servers having users, firewall, disk resources configured for k8s.
- I choose to fully reset/uninstall microk8s between two tests.
- I want try microk8s/containerd-podman-docker for my container management.
- I need a Prometeus for reporting to Grafana the main metrics of working (CPU/RAM/Network & Disk work).
- I wanna try also if I could easily recreate links to my existing NFS persistent storage.

## Solution

- I choose one directory equal one configuration.
- I choose ansible/bash for scripting & only linters as other required tools.
- I avoid kubernetes.core.k8s at first to having more step control, emphating microk8s differences with my old k8s pipeline.
- I defining partial, smallest YAML configuration and related Jinja2 template to produce full k8s YAML files.

Work in progress and for test only.