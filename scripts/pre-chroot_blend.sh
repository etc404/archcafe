#!/bin/bash
# verify boot mode
sep = "____..•..________..•..________..•..____"
echo "Verifying boot mode..."
if [ -d "/sys/firmware/efi/efivars" ]; then
        echo "Booted in UEFI mode, continuing."
else
        echo "Not booted in UEFI mode. I haven't installed arch in a non-UEFI environment so I can't complete steps, I apologize. Exiting..."
        return 1 2>/dev/null || exit 1
fi
echo "$sep \n"

# networking
echo "Connecting to network..."
iwctl
echo "Testing connection..."
ping archlinux.org
echo "$sep \n"

# update clock
echo "Updating clock..."
timedatectl set-ntp true
echo "Clock updated."
echo "$sep \n"

# partitioning
echo "Listing connected drives."
fdisk -l
echo "Enter path of device to install to."
read device
if [ -d "$device" ]; then
        echo "Valid device, continuing."
else
        echo "Invalid device, exiting."
        return 1 2>/dev/null || exit 1
fi
echo "Current partition table"
parted $device print
echo "Would you like to resize partitions [m]anually or [a]utomatically?"
read method
case $method in
        m)
                fdisk $device
                ;;
        a)
                echo "Are you certain you'd like to automatically partition $device? [yes/no]"
                read
                if [$REPLY = "yes"]; then
                        echo "Resizing..."
                        parted $device mklabel gpt \
                                mkpart "EFI system partition" fat32 0% 260MiB \
                                set 1 esp on \
                                mkpart "swap partition" linux-swap 260MiB 772MiB \
                                set 2 swap on \
                                mkpart "root partition" ext4 772MiB 100% \
                                set 3 root on
                        echo "New partition table:"
                        parted $device print
                else
                        echo "Cancelled, exiting."
                        return 1 2>/dev/null || exit 1
                fi
                ;;
        *)
                echo "Invalid response, exiting."
                return 1 2>/dev/null || exit 1
                ;;
esac
echo "$sep \n"

# format partitions
echo "Formatting partitions..."
echo "Enter EFI partition path."
read bootpath
mkfs.fat -F32 $bootpath
echo "Enter SWAP partition path."
read swappath
mkswap $swappath
echo "Enter ROOT partition path."
read rootpath
mkfs.ext4 $rootpath
echo "$sep \n"

# mount partitions
echo "Mounting partitions..."
mount $rootpath
echo "Mounted root."
mkdir /mnt/efi
mount $bootpath
echo "Mounted boot."
swapon $swappath
echo "Activated swap."
echo "$sep \n"

# pacstrap
echo "Running pacstrap..."
pacstrap /mnt base linux linux-firmware base-devel
echo "Pacstrap complete."
echo "$sep \n"

# genfstab
echo "Running genfstab..."
genfstab -U /mnt >> /mnt/etc/fstab
echo "Fstab generated. Previewing..."
vim /mnt/etc/fstab
echo "Fstab finished."
echo "$sep \n"

# afterwards
echo "Run arch-chroot /mnt next, then there are more scripts for your convenience afterward."
echo "Remaining script recommended order:"
echo "locale_roast.sh\nnetwork_roast.sh\nhome_roast.sh\nboot_roast.sh\nterminal_blend.sh\ndisplay_blend.sh\ndesktop_blend.sh\nbluetooth_roast.sh\n"
echo "Afterwards, reboot into the new system. Thank you for using archcafe!"
