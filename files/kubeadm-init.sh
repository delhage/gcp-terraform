#!/bin/bash

kubeadm init --config=kubeadm-config.yaml --upload-certs \
	| tee kubeadm-init.out

mkdir .kube
sudo cp /etc/kubernetes/admin.conf .kube/config
sudo chown ubuntu:ubuntu .kube/config
