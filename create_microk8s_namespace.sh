#!/usr/bin/bash
# cryptography for passwords
export SSL_CERT_DIR=/etc/ssl/certs 
# CREATE NAMESPACE ############################################################
# launch playbook
ansible-playbook        ./production/create_microk8s_namespace.ans \
                        -i ./production/vars/microk8s_hosts.ini \
                        --vault-password-file ~/.vault_pass.txt \
                        --extra-vars '@./production/vars/vault/vault_passwd.yml' \
                        --extra-vars 'config=devopstest' 
# /CREATE NAMESPACE ###########################################################
