#!/bin/bash
# set timezone
sep = "____..•..________..•..________..•..____"
echo "Setting time zone..."
echo "Regions:"
ls /usr/share/zoneinfo/
echo "Enter region."
read region
echo "Cities:"
ls /usr/share/zoneinfo/$region
echo "Enter city."
read city
echo "Setting Timezone..."
ln -sf /usr/share/zoneinfo/$region/$city /etc/localtime
hwclock --systohc
echo "Timezone Set."
echo "$sep \n"

# edit localization
echo "Editing localization..."
echo "Uncomment all locales you will use. Most common is en_US.UTF-8 UTF-8. Press enter to continue."
read
vim /etc/locale.gen
echo "Locales selected."
locale-gen
echo "Created locale.conf, please edit LANG with whichever language you'd prefer to use. Press enter to continue."
read
echo "LANG=en_US.UTF-8" > /etc/locale.conf
vim /etc/locale.conf
echo "Done."
