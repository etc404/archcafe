#!/bin/bash
sep = "____..•..________..•..________..•..____"

# ask for username
echo "Enter preferred user's username."
read username
echo "$sep \n"

# install dunst, kitty, nitrogen, and falkon
echo "Installing dunst, kitty, nitrogen, and falkon."
pacman -S dunst kitty nitrogen falkon
echo "Dunst, kitty, nitrogen, and falkon installed."
echo "$sep \n"

# copy dunst and kitty configs over
echo "Copying dunst and kitty configs..."
mkdir /home/$username/.config/dunst
mkdir /home/$username/.config/kitty
cp /scripts/archlabs/resources/kitty.conf /home/$username/.config/kitty/
cp /scripts/archlabs/resources/dunstrc /home/$username/.config/dunst/
echo "Configs copied."
echo "$sep \n"

# install sound packages
echo "Installing sound packages..."
pacman -S pulseaudio pavucontrol pactl
echo "Sound packages installed."
echo "Done."
