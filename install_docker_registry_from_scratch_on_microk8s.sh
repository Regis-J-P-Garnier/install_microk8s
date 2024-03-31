#!/usr/bin/bash
# install docker registry on microk8s
# INCLUDE #################################################################### 
source "$(pwd)/production/resources/scripts/workflow_lib.sh"

# INPUTS #####################################################################
input_contracts "$@"
skip_step=$?

# WORKFLOW ##################################################################
# TODO: external database file (.csv .sqlite3 ?) and reader ?
declare -ir a_steps_data_width=2 # global RO integer
declare -ar a_steps_data=(
    "$(pwd)/create_microk8s_namespace.sh docker-registry"   "error on creating namespace : debug !"
    "$(pwd)/create_microk8s_pvc.sh"                         "WARN: the PV="pvc-69e084bf-e684-4ebc-9e40-48f00341f2e6" shuld be used ! debug !"
    "$(pwd)/install_docker_registry_on_microk8s.sh"         "installation failed, maybe unistall then reinstall ?"
    ) # global RO array

# MAIN ######################################################################
# run_workflow INT:SKIP_STEP INT:DATA_WIDTH ARR:DATA
run_workflow $skip_step $a_steps_data_width "${a_steps_data[@]}"
exit $?