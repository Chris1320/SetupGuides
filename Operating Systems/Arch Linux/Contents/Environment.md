# Environment

## Hardware

I am using Arch Linux on my laptop because it gives me a functional system while having low resource usage. I am using an old Lenovo G50-70 laptop with an Intel Core i3-4030U, 4GB RAM, and 500GB HDD storage.

## Software

### Disk Partitions

During the installation I've configured my machine to have the following disk partitions:

| Device      | Size                    | Mountpoint      | Filesystem | Label | Description                |
| ----------- | ----------------------- | --------------- | ---------- | ----- | -------------------------- |
| `/dev/sda1` | 600M                    | `/mnt/boot/efi` | FAT32      | EFI   | The EFI partition          |
| `/dev/sda2` | 1G                      | `/mnt/boot`     | EXT4       | BOOT  | The boot partition         |
| `/dev/sda3` | Remaining of the Device | `/mnt`          | Btrfs      | ARCH  | The root and home parition |

`/dev/sda3` will be a [Btrfs filesystem](https://wiki.archlinux.org/title/Btrfs) with the following subvolumes:

| Subvolume         | Description                                 |
| ----------------- | ------------------------------------------- |
| `/mnt/@`          | The root partition                          |
| `/mnt/@home`      | The home partition                          |
| `/mnt/@snapshots` | The partition where snapshots will be saved |

I used to have a dedicated swap partition, but I am now using [zram](https://wiki.archlinux.org/title/Zram) instead.

---

- Previous: [[Arch Linux|Introduction]]
- Next: [[System Installation]]
