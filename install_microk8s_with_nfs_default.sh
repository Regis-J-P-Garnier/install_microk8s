#!/usr/bin/bash
# install microk8s, nfs csi driver and set it as default persistent volume provider  

# INPUTS ######################################################################
# input contract
if [[ $# -gt 1 ]]; then
    echo "no parameters expected, allow one for starting step (0,1...)" >&2 
    exit -1
fi
# assign inputs
declare -i SKIP_STEP=0
if [[ $# -gt 0 ]]; then
    SKIP_STEP=$(($1)) # it's a numeric 
fi

# FUNCTIONS ##################################################################
function run_playbook() {
    # run the playbook script ans report fail when needed
    if [[ $# -ne 2 ]]; then
        echo "function take two string parameters : CMD FAIL_MSG" >&2 
        return -1
    fi
    # assign inputs   
    declare -r CMD=$1
    declare -r FAIL_MSG=$2
    # execute
    echo "<SHELL>" "$CMD" "</SHELL>"
    eval "$CMD"
    RET_CODE=$?
    if [[ ${RET_CODE} -ne 0 ]]; then
        echo 'ERROR '$RET_CODE':' ${FAIL_MSG}
        return $RET_CODE
    fi
}

# TODO: add args and move in a library
function run_workflow(){
    # execute workflow
    declare -ar A_STEPS_DATA=$1
    declare -ir A_STEPS_DATA_WIDTH=$2
    declare -ir SKIP_STEP=$3
    declare -i RET_CODE=-127
    declare -i a_steps_data_length=${#A_STEPS_DATA[@]}
    for (( i=$((SKIP_STEP * A_STEPS_DATA_WIDTH)); i<${a_steps_data_length}; i=$(( i + A_STEPS_DATA_WIDTH )) ));
    do
        echo 'STEP' $((i / 2)) '--------------------------------------------'    
        # mapping data
        declare CMD='run_playbook'
        # ONE LINE in the table workflow definition
        for (( j=0; j<$A_STEPS_DATA_WIDTH; j++));
        do
            # ONE CELL in the table workflow definition 
            declare INDEX=$((i + j))
            CMD=$(echo $CMD \"${A_STEPS_DATA[$INDEX]}\")
        done
        eval ${CMD}
        # run_playbook "$current_CMD" "$current_FAIL_MSG"
        RET_CODE=$?
        echo '/STEP '$((i / 2))'--------------------------------------------'
        if [[ ${RET_CODE} -ne 0 ]]; then return $RET_CODE; fi
    done 
    return $RET_CODE
}

# WORKFLOW ##################################################################
# define
# TODO: external database file (.csv .sqlite3 ?) and reader ?
declare -ir A_STEPS_DATA_WIDTH=2 # global RO integer
declare -ar A_STEPS_DATA=(
    "./install_microk8s.sh"                         'install of microk8s failed: retry (if snap install) or debug !'
    "./install_microk8s_csi_driver_nfs.sh"          'install nfs driver failed: debug !'
    "./create_microk8s_storage_class.sh default"    'install nfs SC or set it as default in default namespace failed: debug !'
    ) # global RO array

# MAIN ######################################################################
# run_workflow ARR:DATA INT:DATA_WIDTH INT:SKIP_STEP
run_workflow A_STEPS_DATA A_STEPS_DATA_WIDTH SKIP_STEP
exit $?


