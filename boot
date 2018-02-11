
Linux Boot  {{{1

MBR/BIOS
    System power up
    BIOS reads first sector on disk, executes code there 
    Partitioned devices: MBR - 512 bytes
        MBR contains boot loader & partition table
        Boot loader usually chains to volume boot record 
    Non-partitioned device: VBR in first sector

Boot loader loads Linux kernel & initramfs into memory.
kernel reads initramfs, loads /init from there if present
init loads disk file system & boots sytem



Initramfs
	replaced initrd in kernel 2.6
    not needed if /usr/ and /etc on same disk as kernel
    Fedora dracut creates one tailored to harware installed on to reduce size ("host-only" mode).  Rescue version is much bigger 


https://www.freedesktop.org/wiki/Software/systemd/FileHierarchy/

Init system
    first process started by kernel
    starts all daemons etc. required by OS
    Later starts user services 



Boot Firmware {{{1
Coreboot {{{2

coreboot is the part of the firmware that initializes the hardware
Payload boots OS

Payloads:
    Chromebook stock payload is depthcharge
    payload that implements a Legacy BIOS bootloader is SeaBIOS
    SeaBIOS installed in section of the firmware normally reserved for booting an OS in Legacy mode (called RW_LEGACY)

UEFI {{{1

ESP EFI System Partition
    does not have to be FAT but this is most compatible

Searches through boot order entries in order for a Device Path + File match
If fails starts Default Boot Behavior process:
    searches removable devices then fixed devices for an ESP (as found in GPT) containing \EFI\BOOT\BOOTX64.efi & executes it
    BOOTX64 looks for file fallback.efi in same directory & executes it
    fallback.efi looks for files *.csv in directories other than BOOT, uses content to create new Boot entires pointing to same disk as fallback.efi was lauched from.


Shell
	Shell.efi from edk2 package
	Copy into EFI subfolder and create entry with efibootmgr
	https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface#edit

    bcfg boot dump -b
        page through boot entries
    bcfg boot mv 3 0
        move third entries to first/default

efibootmgr
    Entries with ID Boot[hex] - leading 0's not needed i.e. 0004 = 4
    Entry format:  HD(1,GPT, PARTUUID)/File(EFI/path )
    PARTUUID from blkid

    Asterick indicates active 
    -c  create entry
    -d  disk containing loader, defaults to /dev/sda
    -l  loader, e.g. elilo.efi
    -L  label for boot manager display
    -o  set boot order ID,ID etc.
    -n  set boot order or next boot only
    -p  parition containing bootloader - default 1
    -b  modify item 
    -v  show UUIDs etc.
    -u  unicode command line arguments, e.g root=/dev/xxx
    
    Delete items
        first reset order without item to be deleted
        delete it
            -b ID -B

	Boot entry
	https://wiki.archlinux.org/index.php/EFISTUB
    efibootmgr -c -d /dev/sdb -p 1 -L "USB drive" -l "\EFI\BOOT\BOOTX64.EFI"
    efibootmgr -c -d /dev/mmcblk0 -p 1 -L "MMC card internal" -l "\EFI\BOOT\BOOTX64.EFI"


	efibootmgr -d /dev/sda -p 1 -c -L "Slackware" -l \\EFI\Slackware\\kernel-generic -u "root=/dev/sdZ rw initrd=/EFI/Slackware/initrd.gz"

Grub with UEFI

grubx64.efi
    Use strings (Debian binutils) with grep to find grub.cfg location. 
    https://blog.learningtree.com/how-does-linux-boot-part-3-uefi-to-shim-to-the-next-link-in-the-chain/





Rescue {{{1

kernel command line
    remove rhgbi quiet
    systemd.unit=rescue.target or 1 

Systemd-Boot {{{1

Install
 bootctl --path=esp install

esp/loader/loader.conf
    default  arch
    timeout  4
    editor   0

Find PARTUUID
    blkid -s PARTUUID -o value /dev/sdxY


Boot Entries:
$esp/loader/entries

title          Arch Linux (LVM)
linux          /vmlinuz-linux
initrd         /initramfs-linux.img
options        root=/dev/mapper/<VolumeGroup-LogicalVolume> rw

title          Fedora 22 (LVM)
linux          /boot/vmlinuz-4.1.6-200.fc22.x86_64 
initrd         /boot/initramfs-4.1.6-200.fc22.x86_64.img
options        root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/root rhgbi resume=/dev/sda5 quiet 

title          Arch Linux
linux          /vmlinuz-linux
initrd         /initramfs-linux.img
options        root=PARTUUID=14420948-2cea-4de7-b042-40f67c618660 rw rootflags=subvol=ROOT


Grub {{{1

Fedora 22 multiboot Guide
https://docs.fedoraproject.org/en-US/Fedora/22/pdf/Multiboot_Guide/Fedora-22-Multiboot_Guide-en-US.pdf

https://wiki.archlinux.org/index.php/GRUB#Installation_2


grub_install --target-x86_64_efi /dev/sda" then copy the grubx64.efi to EFI/BOOT/bootx64.e

Do not use grub2-install on UEFI system!

Update grub config
Debian
    grub-mkconfig -o /boot/grub/grub.cfg 
Fedora
    grub-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
    /etc/grub2-efi.cfg is symlink 

Missing efi bootloader files: reinstall Grub
    dnf reinstall grub2-efi grub2-efi-modules shim

Manual session:
    set grub's root device (location of kernel & initrd) 
        root=(hd0,<boot root dev>
    set prefix (locates grub modules)
        prefix=(hd0,<boot root dev>)/boot/grub2
    load modules for tab completion (not needed anymore?)
        insmod normal
        normal (opens menu)
        insmod linux
    linux /vmlinuz root=/dev/hdax
    initrd /initrd

    If grub not found or not installed
        if unknown, search with
            > find /grub/stage1 (sep boot part)
            > find /boot/grub/stage1 (combined root/boot fs) 
        setup
            > setup (hd0)
            > setup (hd0,<part>)


