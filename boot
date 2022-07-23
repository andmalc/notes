Overview {{{1

Reasons for current grub layout
https://fedoraproject.org/wiki/Changes/UnifyGrubConfig

Firmware on system board selects bootable media
	BIOS - obsolete
	UEFI firmware: select media and *.efi file to run

Boot loader 
	Runs monolithic kernel from media 
	Passes to kernel location of main file system and initial RAM based disk image with essential drivers

Kernel - uses directives passed by boot loader to find main file system and init program

Init program - starts services


Boot loader loads Linux kernel & initramfs into memory.
kernel reads initramfs, loads /init from there if present
init loads disk file system & boots sytem

Init system
    first process started by kernel
    starts all daemons etc. required by OS
    manages sytem state


Boot Firmware {{{1

Initializes processor, memory, and onboard devices and interfaces 

UEFI {{{2

Docs:
https://wiki.archlinux.org/index.php/EFISTUB
https://wiki.debian.org/UEFI
https://wiki.gentoo.org/wiki/Efibootmgr#Configuration
https://fedoraproject.org/wiki/Unified_Extensible_Firmware_Interface

Firmware locates ESP EFI System Partition via its GUID partition type signature.

Searches through boot order entries (stored as EFI variables) for BootCurrent index. 
Finds and Executes efi boot stub file as indicated in corresponding boot entry

Fallback / Default Boot Behavior process:
1.  searches removable devices then fixed devices for an ESP (as found in GPT) containing \EFI\BOOT\BOOTX64.efi & executes it
        BOOTX64 looks for file fallback.efi in same directory & executes it
2.  searches for device with MBR partition type 0xEF (e.g. Fedora installer disk)


RedHat & Fedora default for Secure Booot: \EFI\fedora\shimx64.efi runs grubx64.efi which is configured by grub.cfg which redirects to real grub.cfg under /boot/grub2.

Systemd Boot: Boot stub exectutes kernel directly so bootloader not needed exept to manage configuration.


Coreboot {{{2

coreboot is the part of the firmware that initializes the hardware
Payload boots OS

Payloads:
    Chromebook stock payload is depthcharge
    payload that implements a Legacy BIOS bootloader is SeaBIOS
    SeaBIOS installed in section of the firmware normally reserved for booting an OS in Legacy mode (called RW_LEGACY)

Systemd-Boot {{{2

For Fedora 34
https://kowalski7cc.xyz/blog/systemd-boot-fedora-32

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

Fedora 35 conf entries
	/boot/loader/entries/<machine ID>.conf

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


Initial RAM Disk Image {{{1

Types:
    initrd - obsolete
    initramfs

A binary containing temp filesystem needed to start init and load file system.
Created by dracut 


Systemd boot {{{1

sample config files at /usr/share/systemd/bootctl

To read
https://man.archlinux.org/man/systemd-gpt-auto-generator.8

Repair Windows not booting
    https://unix.stackexchange.com/questions/610779/pop-os-systemd-boot-cant-detect-windows


Partition Layouts {{{1

xbootldr partition
    fs must be vfat unless driver for other fs loaded
    mount ESP at /efi and xbootldr at /boot
    spec managed loader dir, other content such as kernels and initamfs optional
    use bootctl to troubleshoot

/boot
	can be in root partition as long as either 
		- using systemd-boot which supports loading binaries only from EFI or Xbootldr partition
		- boot loader can access the kernel & initramfs images there.  
				grub supports all common setups plus btrfs
				separate boot partition may be necessary if block devices in lvm, raid, or encrypted or if filesystem not supported.



boot manager eg. systemd-boot
	allows editing kernel boot parameters before boot.  

boot manager eg grub
	manages parameters and loads kernel

	https://fedoraproject.org/wiki/Changes/UnifyGrubConfig

firmware boot manager
	may load efi stub loader (in kernel?)

New systemd-boot layout
/boot/efi still points to ESP but moved to /efi
/boot can also point to ESP or mounted to a xbootldr partition
Boot Loader Specification manages /boot/loader dir only.
If /boot => ESP, loader dir must be in root, not under EFI

Fedora 35
	/boot in own partition, ext4, type 8300
		efi => ESP
		grub2
			grub.cfg
			grubenv
		loader
			entries
				grub conf files
		kernel & initrd.img
		

PopOS
	/boot in root fs
    /boot/efi/ is ESP partition
    kernel & initrd.img
		in both and in mounted /boot/efi/EFI/Pop.  
		kernel in ESP has .efi file extension and is executable


Asus Fedora Server
/boot => sda2, xfs
    kernel & initrd.img
    efi/ => part1, type ESP
        EFI
            BOOT
            Fedora

Bootable image created by mkosi
/efi => ESP partition
ESP/
    47....
        empty
    loader/
        loader.conf
        entries/
            empty
    EFI
        BOOT/
            bootx64.efi
        Linux/
            linux-5.11.0-16-generic.efi (EFI Boot Stub)
        Systemd/
            systemd-bootx64.efi*
/boot
    link for ESP/47...
    link to ESP/loader/
    link to /efi
    vmlinuz...




Old {{{1


MBR/BIOS
    System power up
    BIOS reads first sector on disk, executes code there 
    Partitioned devices: MBR - 512 bytes
        MBR contains boot loader & partition table
        Boot loader usually chains to volume boot record 
    Non-partitioned device: VBR in first sector
