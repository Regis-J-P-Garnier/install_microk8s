#!/usr/bin/bash
# install nfs csi driver by helm3 on microk8s 
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
ansible-playbook        ./production/install_microk8s_csi_driver_nfs.ans \
                        -i ./production/vars/microk8s_hosts.ini \
                        --vault-password-file ~/.vault_pass.txt \
                        --extra-vars '@./production/vars/vault/vault_passwd.yml'
# /INSTALL PROMETHEUS #########################################################
# exit
exit 0