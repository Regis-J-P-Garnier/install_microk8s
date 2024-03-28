# Some Basic Scripts for Microk8s Management by Ansible
## Facts
- I have a CI/CD pipeline in test. 
- I use microk8s/docker for my container management.
- I choose to reset/uninstall microk8s between two tests for always having a clean environment.
- I have a RHEL9 & an Ubuntu Server test servers. 
- I need a Prometeus for reporting to Grafana the main metrics of working (CPU/RAM/Network & Disk work).
## Solution
So, I code some simple scripts. Bash then Ansible for testing techs on my servers.
Work in progress.