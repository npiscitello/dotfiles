echo "This utility will rebuild the kernel sources at '/usr/src/linux' and install them. It will then move"
echo "the generated kernel from '/boot/vmlinuz-*' to '/boot/EFI/BOOT/BOOTX64.EFI' to make it bootable as an"
echo "EFI stub (this is a workaround for the VirtualBox EFI implementation but should also work on hardware)"
echo "Type 'update' to continue, or press Ctl-C to exit without making any changes."

if [ $EUID -ne 0 ]; then
  echo -e "\x1B[31mmust be run as root; aborting...\x1B[0m"
  exit 2
fi

read conf
if [ "$conf" != "update" ]; then
  echo -e "\x1B[31mkernel update not confirmed; aborting...\x1B[0m"
  exit 1
fi



echo -e "\n\n\n\x1B[1;32mbuilding kernel...\x1B[0m\n"
cd /usr/src/linux
make -j8



echo -e "\n\n\n\x1B[1;32minstalling kernel...\x1B[0m\n"
cd /usr/src/linux
make install && make modules_install



echo -e "\n\n\n\x1B[1;32mrelocating kernel...\x1B[0m\n"
cd /boot
kernel=$(find /boot -name "vmlinuz-*-gentoo")
echo -e "\x1B[33mmoving '$kernel' to '/boot/EFI/BOOT/BOOTX64.EFI'\x1B[0m"
echo "The current kernel will be moved to '/boot/EFI/BOOT/old_BOOTX64.EFI'."
echo "Type 'move' to confirm the kernel update."

read conf
if [ "$conf" != "move" ]; then
  echo -e "\x1B[31mkernel update not confirmed; aborting...\x1B[0m"
  exit 1
fi

if [ -a /boot/EFI/BOOT/BOOTX64.EFI ]; then
  if [ -a /boot/EFI/BOOT/old_BOOTX64.EFI ]; then
    rm /boot/EFI/BOOT/old_BOOTX64.EFI
  fi
  mv /boot/EFI/BOOT/BOOTX64.EFI /boot/EFI/BOOT/old_BOOTX64.EFI
  mv $kernel /boot/EFI/BOOT/BOOTX64.EFI
fi

if [ -a "$kernel".old ]; then
  rm "$kernel".old
fi

echo -e "\n\n\n\x1B[1;32mkernel updated!\x1B[0m\n"
