#!/usr/bin/bash
# install microk8s, nfs csi driver and set it as default persistent volume provider
# INCLUDE #################################################################### 
source "$(pwd)/production/resources/scripts/workflow_lib.sh"

# INPUTS #####################################################################
input_contracts "$@"
skip_step=$?

# WORKFLOW ##################################################################
# TODO: external database file (.csv .sqlite3 ?) and reader ?
declare -ir a_steps_data_width=2 # global RO integer
declare -ar a_steps_data=(
    "./install_microk8s.sh"                         'install of microk8s failed: retry (if snap install) or debug !'
    "./install_microk8s_csi_driver_nfs.sh"          'install nfs driver failed: debug !'
    "./create_microk8s_storage_class.sh default"    'install nfs SC or set it as default in default namespace failed: debug !'
    ) # global RO array

# MAIN ######################################################################
# run_workflow ARR:DATA INT:DATA_WIDTH INT:SKIP_STEP
run_workflow $a_steps_data $a_steps_data_width $skip_step
exit $?


