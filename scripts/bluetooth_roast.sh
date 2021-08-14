#!/bin/bash
sep = "____..•..________..•..________..•..____"

# install bluetooth tools
echo "Installing bluetooth packages..."
pacman -S bluez bluez-utils blueman pulseaudio-bluetooth
echo "Bluetooth packages installed."
echo "$sep \n"

# enable bluetooth
echo "Enabling bluetooth.service..."
systemctl enable bluetooth
echo "Bluetooth enabled."
echo "$sep \n"

# setup bluetooth audio
echo "Enabling bluetooth audio..."
echo "Uncomment 'load-module module-bluetooth-policy' and 'load-module module-bluetooth-discover'. Press enter to continue."
read
vim /etc/pulse/system.pa
echo "Done."
