#!/usr/bin/bash
# install DOCKER-REGISTRY by a microk8s deployement
# INPUTS #####################################################################
# input contract
if [ $# -ne 0 ]
then
    echo "no parameters expected" >&2 
    exit -1
fi
# inputs
CONFIG=docker-registry
# ENVIRONMENT #################################################################
# cryptography for passwords
export SSL_CERT_DIR=/etc/ssl/certs
# INSTALL DOCKER-REGISTRY #####################################################
# launch playbook
ansible-playbook        ./production/install_docker_registry_on_microk8s.ans \
                        -i ./production/vars/microk8s_hosts.ini \
                         --vault-password-file ~/.vault_pass.txt \
                        --extra-vars '@./production/vars/vault/vault_passwd.yml'\
                        --extra-vars config=${CONFIG}
# /INSTALL DOCKER-REGISTRY ####################################################
# exit
RET_CODE=$?
exit $RET_CODE