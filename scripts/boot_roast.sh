#!/bin/bash
sep = "____..•..________..•..________..•..____"

# install grub and efibootmgr
echo "Installing grub and efibootmgr..."
pacman -S grub efibootmgr
echo "grub and efibootmgr installed."
echo "$sep \n"

# initialize grun
echo "Initializing grub setup."
echo "Enter name for the boot option."
read bootname
echo "Installing grub..."
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=$bootname
echo "Configuring grub..."
grub-mkconfig -o /boot/grub/grub.cfg
echo "Grub configured."
echo "$sep \n"

# microcode
echo "Setting up microcode. Options are [i]ntel, [a]md, [b]oth, or [n]either."
read
case $REPLY in
        i)
                echo "Installing intel ucode..."
                pacman -S intel-ucode
                echo "Intel ucode installed."
                ;;
        a)
                echo "Installing amd ucode..."
                pacman -S amd-ucode
                echo "Amd ucode installed."
                ;;
        b)
                echo "Installing amd and intel ucode..."
                pacman -S intel-ucode amd-ucode
                echo "Amd and intel ucode installed."
                ;;
        *)
                echo "Neither selected. Returning."
                ;;
esac
echo "Reconfiguring grub."
grub-mkconfig -o /boot/grub/grub-cfg
echo "Grub reconfigured. Done."
