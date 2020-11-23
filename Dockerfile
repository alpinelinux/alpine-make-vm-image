FROM alpine:latest

RUN apk update
RUN apk add qemu-img

COPY alpine-make-vm-image /bin/

ENTRYPOINT alpine-make-vm-image
