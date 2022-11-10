# Boot from live USB

# Basic setup
```
loadkeys latin-sv1
iwctl connect [SSID] --passphrase [PWD]
fdisk /dev/nvme0n1
```
# Set up disks
I set up three partitions, /dev/nvme0n1p{1,2,3} of 100MB, 1GB and 998.9GB respective
(I did not bother with encryption as that is what borked my install the first time -_-)

## Create filesystems
```
mkfs.vfat -F32 /dev/nvme0n1p1
mkfs.ext2 /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3

```
## Mount the filesystems
```
mount /dev/nvme0n1p3 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p2 /mnt/boot
mkdir /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi

```
# Bootstrap Arch Linux
```
pacstrap /mnt base base-devel grub-efi-x86_64 efibootmgr zsh vim git dialog net-tools networkmanager ipw2200-fw linux linux-firmware
```

## Generate fstab
```
genfstab -pU /mnt >> /mnt/etc/fstab
```

## Make /tmp a ramdisk
```
echo 'tmpfs	/tmp	tmpfs	defaults,noatime,mode=1777	0	0' >> /mnt/etc/fstab
```

## Change relatime to noatime
```
sed -i 's/relatime/noatime/g' /mnt/etc/fstab
```

## Enter the new system
```
arch-chroot /mnt /bin/bash
```

# Basic setup
```
ln -s /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc --utc
```

## Enable clock sync
```
systemctl start systemd-timesyncd.service
systemctl enable systemd-timesyncd.service
```

## Set the hostname
```
echo [HOST] > /etc/hostname
```

## Update locale
```
echo LANG=en_US.utf8 >> /etc/locale.conf
```

## Set pwd for root
```
passwd
```

## Create a user with a password
```
useradd -m -g users -G wheel -s /bin/zsh [USERNAME]
```

## Let people sudo
```
# uncomment %wheel part
visudo

```

## Create initfs
```
vim /etc/mkinitcpio
# add 'ext4' to MODULES
# add 'keymap' to HOOKS
# move 'keyboard' earlier in MODULES so as to be able to write password with correct keymap
```
Then actually create the initcpio:
```
mkinitcpio -p linux
```

## set up grub
```
grub-install
grub-mkconfig -o /boot/grub/grub.cfg
```

## Time to restart
```
exit

umount -R /mnt
reboot
```

# Set up pacman
```
pacman-key --init
```
## Activate parallel downloads and reshuffle mirrors
```
vim /etc/pacman.conf
vim /etc/pacman.d/mirrorlist

pacman -Syyu
```
# Set up X11
```
pacman -S xorg xorg-server xorg-apps xorg-xinit xterm xorg-fonts-100dpi xorg-fonts-75dpi autorandr
```
# Set up environment

## Install paru
```
mkdir -p ~/repos/utils && cd ~/repos/utils
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

paru -S i3-wm noto-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```
## Install everything through paru
```
mkdir -p ~/repos
git clone https://github.com/JiiXu/dotfiles.git ~/repos/dotfiles
paru -S --needed < ~/repos/dotfiles/pkglist.txt
```

# Set up Nvidia

## blacklist nouveau
echo 'blacklist nouveau' >> /etc/modprobe.d/blacklist.conf
pacman -S nvidia nvidia-utils

## Add gxf card to xorg server
```
# /etc/X11/xorg.conf.d/20-nvidia.conf

Section "OutputClass"
Identifier "intel"
MatchDriver "i915"
Driver "modesetting"
EndSection

Section "OutputClass"
Identifier "nvidia"
MatchDriver "nvidia-drm"
Driver "nvidia"
Option "AllowEmptyInitialConfiguration"
Option "PrimaryGPU" "yes"
ModulePath "/usr/lib/nvidia/xorg"
ModulePath "/usr/lib/xorg/modules"
EndSection
```
# Set up pacman hook to compile module on nvidia updates
```
# /etc/pacman.d/hooks/nvidia.hook

[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux

[Action]
Description=Update nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c  'grep -q "^linux$" || mkinitcpio -P'
```
# Neovim
`nvim-packer-git` has probably already been installed. Just run nvim, ignore
the error messages and once in nvim do
```
:PackerSync
```
Restart nvim.

# Korean
`ibus` is already installed.

# /etc/environment

GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus
GLFW_IM_MODULE=ibus
```

Run `ibus-setup` to configure the input method.
