#!/bin/sh

echo "generate iso...."

rm -f minimal_linux_live.iso

cd work/kernel
cd $(ls -d *)

make isoimage FDINITRD=../../rootfs.cpio.gz
cp arch/x86/boot/image.iso ~/vmware/iso/test.iso

cd ../../..
