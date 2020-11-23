FROM alpine:latest

RUN apk update
RUN apk add qemu-img e2fsprogs

COPY alpine-make-vm-image /bin/
COPY entrypoint.sh /bin/

VOLUME /out

RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT ["/bin/sh", "/bin/entrypoint.sh"]
