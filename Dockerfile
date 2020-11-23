FROM alpine:latest

RUN apk update
RUN apk add qemu-img e2fsprogs xorriso

COPY alpine-make-vm-image /bin/

ENTRYPOINT alpine-make-vm-image
