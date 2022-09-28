#!/bin/bash

echo "[k8s]" > inventory
terraform output|sed -e 's/^ip_//' -e 's/ = "/ ansible_host=/' -e 's/"//' >> inventory
