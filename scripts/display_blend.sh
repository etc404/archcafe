#!/bin/bash
sep = "____..•..________..•..________..•..____"

# get username
echo "Enter preferred user's username."
read username
echo "$sep \n"

# install lightdm and xorg
echo "Installing lightdm and xorg..."
pacman -S lightdm lightdm-pantheon-greeter xorg
echo "Lightdm and xorg installed."
echo "$sep \n"

# setup lightdm
echo "Setting up lightdm..."
echo "Find [Seat:*] in the lightdm config and change the greeter-session section to lightdm-pantheon-greeter. Press enter to continue."
read
vim /etc/lightdm/lightdm.conf
echo "Lightdm config finished."
echo "$sep \n"

# install bspwm, sxhkd, and lemonbar
echo "Installing bspwm, sxhkd, and lemonbar."
pacman -S bspwm sxhkd
yay -S lemonbar-xft-git
echo "Bspwm, sxhkd, and lemonbar installed."
echo "$sep \n"

# copy bspwm, sxhkd, and lemonbar configs over
echo "Copying config files..."
mkdir /home/$username/.config/bspwm
mkdir /home/$username/.config/sxhkd
mkdir /home/$username/.config/lemonbar
cp /scripts/archcafe/resources/bspwmrc /home/$username/.config/bspwm/
cp /scripts/archcafe/resources/sxhkdrc /home/$username/.config/sxhkd/
cp /scripts/archcafe/resources/lemonbar /home/$username/.config/lemonbar
echo "Configs copied. Done"
