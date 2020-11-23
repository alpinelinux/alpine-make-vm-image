# alpine-make-mbr

This is a fork of `alpine-make-vm-image` that can run inside `WSL2`.
As for now it only supports the `-s` option.

## Why

alpine-make-vm-image uses `qemu-nbd` which requires an `NBD` device that is nonexistent in `WSL2`.

This fork uses the available `loop` device instead to make a bootable Alpine MBR.

# Usage

Use the wrapper script `make-image.sh` in order to create a bootable image:

```bash
./make-image [IMAGE_SIZE] [IMAGE_NAME]
```

