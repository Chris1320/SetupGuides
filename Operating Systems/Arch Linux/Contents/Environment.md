# Environment

## Hardware

I am using Arch Linux on my laptop because it gives me a functional system while having low resource usage. I am using an old Lenovo G50-70 laptop with an Intel Core i3-4030U, 4GB RAM, and 500GB HDD storage.

## Software

### Disk Partitions

During the installation I've configured my machine to have the following disk partitions:

| Device      | Size                    | Mountpoint      | Filesystem | Label | Description                             |
| ----------- | ----------------------- | --------------- | ---------- | ----- | --------------------------------------- |
| `/dev/sda1` | 600M                    | `/mnt/boot/efi` | FAT32      | EFI   | The EFI partition                       |
| `/dev/sda2` | 1G                      | `/mnt/boot`     | EXT4       | BOOT  | The boot partition                      |
| `/dev/sdaX` | 2G                      | ZRAM            | ZRAM       | ZRAM  | Optional, The device for ZRAM writeback |
| `/dev/sdaY` | Remaining of the device | `/mnt`          | Btrfs      | ARCH  | The root and home parition              |

If your machine has a RAM size of 8GB or lower, I recommend that you create a separate partition for [ZRAM](https://wiki.archlinux.org/title/Zram), `/dev/sdaX`, as its backing device. `/dev/sdaY` will be a [Btrfs filesystem](https://wiki.archlinux.org/title/Btrfs) with the following subvolumes:

| Subvolume         | Description                        |
| ----------------- | ---------------------------------- |
| `/mnt/@`          | The root partition                 |
| `/mnt/@home`      | The home partition                 |
| `/mnt/@var_log`   | The partition for system logs      |
| `/mnt/@snapshots` | The partition for system snapshots |

> [!ERROR] Important Note
> 
> The suffixes `X` and `Y` in `/dev/sda_` are placeholders! They could be `/dev/sda3`, `/dev/sda4`, and so on... Check `fdisk -l` to confirm.

---

- Previous: [[Arch Linux|Introduction]]
- Next: [[System Installation]]
