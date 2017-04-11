#!/bin/bash

export VM_NAME=centos72
export VM_VERSION=1.3

#if [ "$1" = "output-centos72-vmware-iso/centos72.vmx" ]; then
if [ -f "output-centos72-vmware-iso/centos72.vmx" ]; then
	ovftool output-$VM_NAME-vmware-iso/$VM_NAME.vmx box/ovf/$VM_NAME-$VM_VERSION.ovf
	cd box/ovf
	zip -r $VM_NAME-$VM_VERSION.zip $VM_NAME*
fi
