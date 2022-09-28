#!/bin/bash

IP1=$(terraform output -json|jq .ip_cp.value)
IP2=$(terraform output -json|jq .ip_worker.value)
echo '{"k8s":{"hosts":["cp","worker"]},"_meta":{"hostvars":{"cp":{"ansible_host":'$IP1'},"worker":{"ansible_host":'$IP2'}}}}'
