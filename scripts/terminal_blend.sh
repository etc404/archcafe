#!/bin/bash
sep = "____..•..________..•..________..•..____"

# get username
echo "Enter preferred user's username"
read username
echo "$sep \n"

# install terminal tools
echo "Installing zsh, ranger, vim, git, and lynx..."
pacman -S zsh ranger vim git lynx
echo "Installed."
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "oh-my-zsh installed."
echo "$sep \n"

# copy configs
echo "Copying vim configs..."
cp /scripts/archcafe/resources/.vimrc /home/$username/
echo "Vim configs copied."
echo "$sep \n"

# install yay
echo "Installing yay..."
previouswd = $PWD
cd /opt
git clone https://aur.archlinux.org/yay.git
chown -R $username ./yay
cd yay
makepkg -si
echo "Yay installed. Done."
cd $previouswd
