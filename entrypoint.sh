#!/bin/sh

if [ "$#" -ne "2" ]; then
	echo USAGE: $0 [SIZE] [NAME]
	exit 1
fi

alpine-make-vm-image -f raw -s $1 /out/$2
