# Arch Installation
This repository contains some base instructions for installing Arch Linux. Start with following the step by step guide to get a base installation. Then clone this repository and run then ansible playbook to complete the installation for the user.

## Applications
| Function | Name |
| --- | --- |
| X Compositor | Compton |
| Status Bar | Polybar |
| Application Launcher | Rofi |
| Notification Daemon | Dunst |
| Clipboard Manager | Clipit |
| Terminal Emulator | rxvt-unicode |
| Image Viewer | Feh |
| Pdf Viewer | zathura |

## Step By Step
Download the latest [Arch ISO](https://archlinux.org/download/), then flash it to a USB drive. When complete insert the drive into the target machine and boot from it.
```bash
dd bs=4M if=path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync
```

To list keymaps and load a specific one.
```bash
localectl list-keymaps
loadkeys <keymap>
```

Make sure that you have an internet connection.
```bash
curl google.com
```

Partition the storage device Arch will be installed to. Follow the below for details about what partitions to create.
```bash
cfdisk /dev/sda
```

| Mount point | Partition | Type | Suggested Size |
| --- | --- | --- | --- |
| /boot or /efi | /dev/sda1 | EFI system partition | 260 MiB |
| / | /dev/sda2 | Linux x86-64 root (/) | 23-32 GiB |
| [ SWAP ] | /dev/sda3 | Linux Swap | 23-32 GiB |
| /home | /dev/sda4 | Linux /home | Remainder of device |

Format the new partitions.
```bash
mkfs.fat -F32 /dev/sda1 # EFI needs to be FAT partition

mkswap /dev/sda3
swapon /dev/sda3

mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda4
```

Mount root and home partitions.
```bash
mount /dev/sda2 /mnt
mkdir /mnt/home
mount /dev/sda4 /mnt/home
```

Install the system.
```bash
pacstrap /mnt base
```

Generate fstab file.
```bash
genfstab -U -p /mnt >> /mnt/etc/fstab
```

Chroot to installed system.
```bash
arch-chroot /mnt /bin/bash
```

Install grub and efi boot manager, then set them up.
```bash
pacman -S grub efibootmgr
mkdir /boot/efi
mount /dev/sda1 /boot/efi

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

exit
reboot
```

You should now have a clean installation of Arch that you can boot to. Sign in as the root user and install the sudo package.
```bash
pacman -S sudo
```

Enable the "wheel" group by running `visudo` and uncomment the line `# %wheel ALL=(ALL) ALL.

Then add a new user that belongs to the wheel group.
```bash
useradd -m -g users -G wheel -s /bin/bash <username>
passwd <username>
exit
```

Sign into the new user and clone this repo. Then run the ansible playbook to complete the installation.
```
sudo pacman -S git ansible
git clone https://github.com/phillebaba/arch-linux-installation.git
cd arch-linux-installation
ansible-playbook -K playbook.yml
```
