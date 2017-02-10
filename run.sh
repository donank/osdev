#!/bin/sh

#This script automates compiling, linking and iso building process and runs the iso file using qemu directly

#Step 1- Compile the kernel.c file

i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

#Step 2- Link kernel.o and boot.o 

i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

#Step 3- Build the iso file 

cp myos.bin isodir/boot/myos.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o myos.iso isodir

#Step 4- Run the file myos.iso using QEMU

qemu-system-i386 -cdrom myos.iso
