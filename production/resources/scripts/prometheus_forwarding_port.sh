#!/usr/bin/bash
# forward prometheus from a microk8s deployement to ($1:$2)
# input contract
if [ $# -ne 2 ]
then
    echo "not enought parameters, expected : address port" >&2 
    exit -1
fi
# inputs
PROMETHEUS_ADDRESS=$1
PROMETHEUS_PORT=$2
# exec
microk8s kubectl -n monitoring port-forward --address ${PROMETHEUS_ADDRESS} prometheus-kube-prometheus-stack-prometheus-0 ${PROMETHEUS_PORT}:9090 &
PROMETHEUS_FORWARD_PID=$!
# echo STDOUT
echo ${PROMETHEUS_FORWARD_PID}
# exit
exit 0