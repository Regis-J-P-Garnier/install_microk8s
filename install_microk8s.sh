#!/usr/bin/bash
# install microk8s
# INPUTS#######################################################################
# input contract
if [ $# -ne 0 ]
then
    echo "no parameters expected" >&2 
    exit -1
fi
# ENVIRONMENT #################################################################
# cryptography for passwords
export SSL_CERT_DIR=/etc/ssl/certs
# INSTALL SNAP ################################################################
# requirements (role)
ansible-galaxy          install \
                        -r ./production/requirements/install_microk8s_snap_requirements.yml                        
# launch playbook
# WARN: often fail on first try when snap not previously installed 
#       (search for installed snap before update of the info in the register)
#       just INTERRUPT AND RETRY
ansible-playbook        -b ./production/install_microk8s_snap.ans \
                        -i ./production/vars/microk8s_hosts.ini \
                        --vault-password-file ~/.vault_pass.txt \
                        --extra-vars '@./production/vars/vault/vault_passwd.yml'
# /INSTALL SNAP ###############################################################
# exit
RET_CODE=$?
exit $RET_CODE