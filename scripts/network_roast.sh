#!/bin/bash
# install network packages
sep = "____..•..________..•..________..•..____"
echo "Installing NetworkManager..."
pacman -S networkmanager
echo "Enabling NetworkManager service..."
systemctl enable NetworkManager
echo "NetworkManager enabled."
echo "$sep \n"

# set hostname
echo "Setting hostname..."
echo "What hostname would you like?"
read hostname
echo "Establishing hostname..."
echo $hostname > /etc/hostname
echo "127.0.0.1     localhost\n::1         localhost\n127.0.1.1       $hostname.localhost $hostname" > /etc/hosts
echo "Hostname set up."
echo "$sep \n"
