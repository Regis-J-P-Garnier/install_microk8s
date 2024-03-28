#!/usr/bin/bash
# create a namespace on microk8s
# INPUTS ######################################################################
# input contract
if [ $# -ne 1 ]
then
    echo "one parameter expected : <config>" >&2 
    exit -1
fi
# inputs
CONFIG=$1
# ENVIRONMENT #################################################################
# cryptography for passwords
export SSL_CERT_DIR=/etc/ssl/certs 
# CREATE NAMESPACE ############################################################
# launch playbook
ansible-playbook        ./production/create_microk8s_namespace.ans \
                        -i ./production/vars/microk8s_hosts.ini \
                        --vault-password-file ~/.vault_pass.txt \
                        --extra-vars '@./production/vars/vault/vault_passwd.yml' \
                        --extra-vars config=${CONFIG} 
# /CREATE NAMESPACE ###########################################################
# exit
exit 0