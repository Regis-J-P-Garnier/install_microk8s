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
    "$(pwd)/install_microk8s.sh"                         "install of microk8s failed: retry (if snap install) or debug !"
    "$(pwd)/install_microk8s_csi_driver_nfs.sh"          "install nfs driver failed: debug !"
    "$(pwd)/create_microk8s_storage_class.sh default"    "install nfs SC or set it as default in default namespace failed: debug !"
    ) # global RO array

# MAIN ######################################################################
# run_workflow INT:SKIP_STEP INT:DATA_WIDTH ARR:DATA
run_workflow $skip_step $a_steps_data_width "${a_steps_data[@]}"
exit $?


