# System Installation

If you haven't installed Arch Linux yet, continue reading. It is recommended to start from scratch since the dotfiles are tightly integrated with how my system is set up. If you know what you are doing, you might want to skip to the [[Manual Customization|manual]] or [[Automatic Customization|automatic]] customization steps.

I recommend that you read the [Arch Linux Wiki](https://wiki.archlinux.org/)'s [installation guide](https://wiki.archlinux.org/title/Installation_guide) instead since it is more updated and accurate than a guide that is maintained by one hobbyist like me. I also recommend reading [arch.d3sox.me](https://arch.d3sox.me/) if you have trouble understanding the wiki.

## Pre-Installation

### Preparing the Installation Medium

I assume that you know how to boot into the Arch Linux ISO. You can download the ISO from [their website](https://www.archlinux.org/download/), and use [Ventoy](https://www.ventoy.net/en/index.html) to boot into your USB Flash Drive.

> [!CAUTION] After this point, I assume that you are now in the live ArchISO system.

### Preparing the Console

If you are not using a US keyboard, you might want to change your keyboard layout.

```bash
localectl list-keymaps  # list available layouts
loadkeys <keymap> # load a keymap. e.g., `de-latin1`
```

### Verifying Internet Connection

Internet connection via Ethernet should be working out of the box. If you are using a wireless connection, perform the following commands:

```bash
iwctl
device list
# your device name might be different (replace wlan0)
station wlan0 scan
station wlan0 get-networks
# replace <SSID> with your network name from the previous command
station wlan0 connect <SSID>
exit
```

> [!TIP] If you are having problems turning on your wireless NIC, make sure that it is not being soft-blocked by `rfkill`.

To make sure that you have an internet connection, ping the Arch Linux website.

```bash
ping -c 4 archlinux.org
```

### Setting Up Time and Date

Make sure that the time and date is synchronized.

```bash
timedatectl set-ntp true
```

### Check if The System Booted in UEFI

```bash
ls /sys/firmware/efi/efivars
```

If the directory does not exist, you are in BIOS mode. It is most likely that you want to use UEFI, so check the wiki to know how to boot into UEFI mode.

## Storage Preparation

### Partitioning and Mounting the Disks

List all block devices by running the following command:

```bash
fdisk -l
```

In my case, my main storage device is located at `/dev/sda`. So we run the following command: (Your device might have a different name)

```bash
fdisk /dev/sda
```

Partition the device following the structure shown in [[Environment#Disk Partitions|Environment > Disk Partitions]]. If you have different needs, you can see more examples in the [Arch Linux Wiki](https://wiki.archlinux.org/title/Partitioning#Example_layouts) and [d3sox](https://arch.d3sox.me/installation/partitioning-formatting#size-recommendations)'s guide. After saving the changes made by `fdisk`, create the filesystems.

```bash
mkfs.fat -F32 -n EFI /dev/sda1  # Create a FAT32 filesystem in `/dev/sda1` labeled "EFI"
mkfs.ext4 -L BOOT /dev/sda2  # Create an EXT4 filesystem in `/dev/sda2` labeled "BOOT"
mkfs.btrfs -L ARCH /dev/sdaY  # Create a BTRFS filesystem in `/dev/sdaY` labeled "ARCH"

# Mount /mnt to create Btrfs subvolumes.
mount --mkdir /dev/sdaY /mnt

# Create Btrfs subvolumes
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots

# Unmount /mnt
umount /mnt

# Mount the partitions in their respective mountpoints.
mount --mkdir -o noatime,compress-force=zstd:3,subvol=@ /dev/sdaY /mnt
mount --mkdir -o noatime,compress-force=zstd:3,subvol=@home /dev/sdaY /mnt/home
mount --mkdir -o noatime,compress-force=zstd:3,subvol=@snapshots /dev/sdaY /mnt/snapshots
mount --mkdir /dev/sda2 /mnt/boot
mount --mkdir /dev/sda1 /mnt/boot/efi
```

> [!NOTE]+ Regarding Btrfs Compression
> 
> The [compression level](https://btrfs.readthedocs.io/en/latest/Compression.html#compression-levels) of zstd may vary, depending on your storage type. For slower devices such as HDDs, it is better to optimize the file size so that the system will spend less time reading and writing. Meanwhile, the added compression/decompression time is (theoretically) slowing down I/O for faster devices.[^1]
> 
> Basically, set `compress-force=zstd:N`...
> 
> - Within `2-5` if you have a rotating storage device
> - To `2` if you have a SATA SSD
> - To `1` if you have an NVMe SSD
> 
>  Depending on your needs, you can set the compression levels <u>higher</u> if *storage space* is more important or <u>lower</u> if *latency or bandwidth* is more important.

[^1]: Source: [Reddit -  Which compression level should I choose?](https://www.reddit.com/r/btrfs/comments/15i0psb/comment/juvubkw/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)

## Installing Arch Linux

### Rank the Mirrors

Use [reflector](https://wiki.archlinux.org/title/Reflector) to rank the mirror servers.

```bash
reflector \
	--latest 10 \
	--age 18 \
	--protocol https,rsync \
	--sort rate \
	--save /etc/pacman.d/mirrorlist
```

### Perform the Base Installation

Use the `pacstrap` command to install Arch Linux into your system.

> [!WARNING]
> 
> To ensure system stability, append the microcode package for
> your CPU to the following command:
>
> - `amd-ucode` for AMD CPUs
> - `intel-ucode` for Intel CPUs
>
> See [Arch Linux Wiki > Microcode](https://wiki.archlinux.org/index.php/Microcode)

```bash
pacstrap -K /mnt \
    base base-devel linux linux-firmware linux-headers \
    iwd networkmanager networkmanager-openvpn \
    networkmanager-pptp networkmanager-vpnc \
    wireless_tools wpa_supplicant ifplugd \
    sysfsutils usbutils btrfs-progs e2fsprogs dosfstools lvm2 \
    inetutils dhcping traceroute rsync \
    earlyoom nano less which tree sudo reflector \
    dialog man-db man-pages openssh \
    git git-lfs xdg-utils xdg-user-dirs
```

Append more package names as needed. For example, my laptop has Broadcom wireless devices so I have to install `broadcom-wl` as well. This command may take a while to complete.

### Generate `fstab`

Generate an fstab file by running either of the following commands:

```bash
genfstab -L /mnt >> /mnt/etc/fstab  # Define by labels
genfstab -U /mnt >> /mnt/etc/fstab  # Define by UUIDs
```

> [!NOTE] Check the `/mnt/etc/fstab` file for any errors.

### Chroot into Your New Arch Linux System

```bash
arch-chroot /mnt
```

### Configure Pacman

```bash
nano /etc/pacman.conf
```

#### Enable `multilib` Repository

Uncomment the following lines to make 32-bit libraries available to download.

```text
[multilib]
Include = /etc/pacman.d/mirrorlist
```

#### Enable Parallel Downloads

Uncomment the following line to enable parallel downloading of files. You can change the value to whatever you like.

```text
ParallelDownloads = 5
```

#### Other Stuff

Uncomment/Add the following lines under `Misc options`:

1. `Color`
2. `ILoveCandy`
3. `VerbosePkgLists`

#### Post-Configuration

After editing the configuration file, you may now save and close it. Run `pacman -Syu` to update the repositories.

### Add `zram`

Instead of having a swap partition, we are going to use zram instead.

```bash
pacman -S zram-generator
```

After installation, create/edit `/etc/systemd/zram-generator.conf` and replace its contents with the following:

```toml
[zram0]
zram-size = min(ram, 8192)
compression-algorithm = zstd
```

> [!NOTE]- ZRAM Backing Device
> 
> If you opted for using ZRAM's writeback feature, get the partition UUID of your backing device partition (`/dev/sdaX`) by looking at the results of `ls -lAh /dev/disk/by-partuuid`, and add the following line in `/etc/systemd/zram-generator.conf`, under `[zram0]`:
> 
> ```toml
> writeback-device = /dev/disk/by-partuuid/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
> ```

We can also optimize our `zram` configuration by creating `/etc/sysctl.d/99-vm-zram-parameters.conf` and adding the following in the file:

```
vm.swappiness = 180
vm.watermark_boost_factor = 0
vm.watermark_scale_factor = 125
vm.page-cluster = 0
```

### Installing The Graphics Driver

First, install Mesa and Vulkan graphics drivers.

```bash
pacman -S mesa lib32-mesa vulkan-icd-loader lib32-vulkan-icd-loader
```

Depending on your graphics card, run the appropriate command to install the graphics drivers needed:

| Manufacturer                              | Command                                                                                                                                                                           |
| ----------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AMD (New)                                 | `pacman -S xf86-video-amdgpu libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau libva-vdpau-driver lib32-libva-vdpau-driver vulkan-radeon lib32-vulkan-radeon` |
| AMD (Old)                                 | `pacman -S xf86-video-ati libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau libva-vdpau-driver lib32-libva-vdpau-driver vulkan-radeon lib32-vulkan-radeon`    |
| Intel \[[[#^f23282\|See warning below]]\] | `pacman -S xf86-video-intel vulkan-intel`                                                                                                                                         |
| Nvidia (Nouveau)                          | `pacman -S xf86-video-nouveau nvidia-utils lib32-nvidia-utils libvdpau lib32-libvdpau`                                                                                            |
| Virtual Machine (Hyper-V)                 | `pacman -S xf86-video-fbdev`                                                                                                                                                      |
| Virtual Machine (Others)                  | `pacman -S xf86-video-vmware`                                                                                                                                                     |

> [!WARNING]- Troubleshooting
> 
> > [!WARNING]- Intel
> >
> > According to [Arch Linux Wiki > Intel Graphics > Installation](https://wiki.archlinux.org/title/Intel_graphics#Installation), there are multiple problems when installing `xf86-video-intel` so you might want to **not install** the package.
> 
> > [!WARNING]- NVIDIA
> > 
> > If you are having problems, read [Arch Linux Wiki > NVIDIA](https://wiki.archlinux.org/title/NVIDIA).

^f23282

### `initramfs` Setup

Now, we need to edit our initial ram disk by running `nano /etc/mkinitcpio.conf`. Inside the parenthesis of `MODULES=()`, add the following (separated by a space):

- `btrfs` and `ext4`, since we are using Btrfs and EXT4 as our filesystems.
- `amdgpu` if you are running the new AMD GPU driver, `i915` if Intel, or `nvidia nvidia_modeset nvidia_uvm nvidia_drm` if you use proprietary NVIDIA drivers.

As an example, my machine has a built-in Intel GPU so I have the following:

```bash
MODULES=(btrfs ext4 i915)
```

> [!WARNING] If you are running proprietary NVIDIA drivers, remove `kms` inside `HOOKS=()`.

After editing, we run `mkinitcpio -P` to process all preset files.

### Install Bootloader

In this step, I assume that you are installing on a UEFI system. Otherwise, check [d3sox](https://arch.d3sox.me/installation/install-bootloader) for more information.

> [!TIP]+ GRUB OS Prober
> 
> If you want to automatically detect other operating systems, run `nano /etc/default/grub` and add/uncomment the following line:
>
> ```bash
> GRUB_DISABLE_OS_PROBER=false
> ```

```bash
pacman -S grub efibootmgr os-prober grub-btrfs
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

> [!NOTE]+
> 
> If you forgot to perform `grub-mkconfig` and shut down/reboot the system instead (which I _totally_ did not do while installing Arch), just boot into your live USB again, mount the partitions, and `chroot` into your system.

### Setup Hostname

`<YOUR_HOSTNAME>` will be the name of your machine. Change it to whatever you like, but following [RFC1178](https://tools.ietf.org/html/rfc1178) is recommended.

```bash
printf '<YOUR_HOSTNAME>' > /etc/hostname
nano /etc/hosts
```

When the text editor opens, add the following to the file and save:

```text
127.0.0.1   localhost
::1         localhost
127.0.1.1   <YOUR_HOSTNAME>.local  <YOUR_HOSTNAME>
```

### Setting Up Locale

Uncomment the languages that you plan to use in `/etc/locale.gen` and then generate the locales.

```bash
nano /etc/locale.gen
locale-gen

printf 'LANG=en_US.UTF-8' > /etc/locale.conf  # You can change the locale if you want
export LANG=en_US.UTF-8
```

### Update the Time

```bash
# Replace `Region/City` with your region and city.
# tab-completion is available.
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc
```

### Setting Up Users

> [!TIP] It is recommended to use strong passwords for your user accounts.

#### Set Root Password

```bash
passwd
```

#### Add A Non-Root User Account

A common security practice is that you should **not** use the root account unless needed and you know that it is safe to run. To create a non-root user, run the commands below and change the parameters to the values you desire.

> [!QUESTION] For more information, visit the [Arch wiki](https://wiki.archlinux.org/title/Users_and_groups).

```bash
# Change <USERNAME> with your desired username.
useradd -mG audio,video,input,storage,wheel,sys,log,rfkill,lp,adm -s /bin/bash <USERNAME>
passwd <USERNAME>
```

To enable `sudo` in the newly-created account, run the following command:

```bash
EDITOR=nano visudo
```

And uncomment the following line to allow members of the group `wheel` to execute any command:

```text
%wheel ALL=(ALL:ALL) ALL
```

### Enable Networking-Related Services

First, create or edit `/etc/NetworkManager/conf.d/wifi_backend.conf` and insert the following configuration:

```toml
[device]
wifi.backend=iwd
```

Then, enable the `NetworkManager` service.

```bash
systemctl enable NetworkManager.service
```

> [!TIP] More information: [Arch Linux Wiki > Wireless](https://wiki.archlinux.org/title/Network_configuration/Wireless)

### Enable Other System Services

Edit `/etc/xdg/reflector/reflector.conf` and replace its contents with the following:

```
--latest 10
--age 18
--protocol https,rsync
--sort rate
--save /etc/pacman.d/mirrorlist
```

Lastly, enable the services:

```bash
systemctl enable reflector.service
systemctl enable earlyoom.service
```

## Reboot

```bash
exit  # Exit the chroot environment
reboot  # Reboot the system
```

---

- Previous: [[Environment]]
- Next: [[Automatic Customization]]
