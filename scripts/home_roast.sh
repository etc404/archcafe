#!/bin/bash
sep = "____..•..________..•..________..•..____"

# set root password
echo "Enter root password."
passwd
echo "Enter main user username:"
read username
echo "Enter login shell path:"
read shellpath
useradd -m -G -s $shellpath $username
echo "User '$username' created."
echo "Enter user '$username' password."
passwd $username
echo "$sep \n"

# initiate sudo
echo "Installing sudo..."
pacman -S sudo
echo "Editing sudoers. Example entry: '$username    ALL=(ALL) ALL'. Press enter to continue."
read
EDITOR=vim visudo
echo "Sudoers updated."
echo "$sep \n"

# install and run xdg-user-dirs
echo "Installing xdg-user-dirs..."
pacman -S xdg-user-dirs
echo "Changing user to run xdg-user-dirs-update..."
sudo -u $username xdg-user-dirs-update
echo "$username home directory generated."
echo "Done."
