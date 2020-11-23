#!/bin/bash

IMAGE_NAME="guye1296/alpine-make-mbr"

if [ "$#" -ne 2 ]; then
	echo "USAGE: $0 [SIZE] [NAME]"
	exit 1
fi

mkdir -p build
docker run --privileged -v $PWD/build:/out --rm $IMAGE_NAME $1 $2
