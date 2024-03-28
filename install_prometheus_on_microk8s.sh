#!/usr/bin/bash
# install prometheus by a microk8s deployement
# INPUTS ######################################################################
# input contract
if [ $# -ne 0 ]
then
    echo "no parameters expected" >&2 
    exit -1
fi
# ENVIRONMENT #################################################################
# cryptography for passwords
export SSL_CERT_DIR=/etc/ssl/certs
# INSTALL PROMETHEUS ##########################################################
# launch playbook
ansible-playbook        ./production/install_prometheus_on_microk8s.ans \
                        -i ./production/vars/microk8s_hosts.ini \
                         --vault-password-file ~/.vault_pass.txt \
                        --extra-vars '@./production/vars/vault/vault_passwd.yml'
# /INSTALL PROMETHEUS #########################################################
# exit
exit 0