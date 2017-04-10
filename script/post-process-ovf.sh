#!/bin/bash

if [ "$1" = "output-centos72-vmware-iso/centos72.vmx" ]; then
	ovftool output-$VM_NAME-vmware-iso/$VM_NAME.vmx box/ovf/$VM_NAME.ovf
	cd box/ovf
	zip -r $VM_NAME.zip $VM_NAME
fi
