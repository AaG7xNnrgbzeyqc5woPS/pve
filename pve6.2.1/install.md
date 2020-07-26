# see:
   [proxmox pve wiki Main Page](https://pve.proxmox.com/wiki/Main_Page)   
   [proxmox pve 6.2 download ](https://pve.proxmox.com/wiki/Downloads#Proxmox_Virtual_Environment_6.2_.28ISO_Image.29)  
   [proxmox pve 6.2 ISO info](https://www.proxmox.com/en/downloads/item/proxmox-ve-6-2-iso-installer)  
   
   
# 1. Download iso image
## 1.1. Proxmox VE 6.2 ISO Installer information: 
  [Proxmox VE 6.2 ISO Installer ](https://www.proxmox.com/en/downloads/item/proxmox-ve-6-2-iso-installer)  
  
  
    Last update: 12 May 2020
    File size: 862.54 MB
    Version: 6.2-1

    SHA256SUMS for the ISO:
    d8fb3cfba19d38aa0c05452a954150f96e3ee455a36d52427aa26e6906fb8bff
    
  [Proxmox VE 6.2 ISO Installer (BitTorrent) ](https://www.proxmox.com/en/downloads/item/proxmox-ve-6-2-iso-installer-bittorrent) 
    
    Last update: 12 May 2020
    File size: 33.86 KB
    Version: 6.2-1

    SHA256SUMS for the ISO:
    d8fb3cfba19d38aa0c05452a954150f96e3ee455a36d52427aa26e6906fb8bff
    
## 1.2. First install Transmission for downlaod BitTorrent iso
    sudo pacman -Sy transmission-gtk
   
   run transmission-gtk at cli:   
   
     transmission-gtk
   
## 1.3. download "proxmox-ve-6-2-iso-installer-bittorrent"
### 1.3.1. click this link and down bittorrent seed file:
   [Proxmox VE 6.2 ISO Installer (BitTorrent) ](https://www.proxmox.com/en/downloads/item/proxmox-ve-6-2-iso-installer-bittorrent)  
   
### 1.3.2. download "Proxmox VE 6.2 ISO Installer" with transmission-gtk  and seed file
### 1.3.3. check sha512sum for  "Proxmox VE 6.2 ISO"
    sha256sum proxmox-ve_6.2-1.iso
    d8fb3cfba19d38aa0c05452a954150f96e3ee455a36d52427aa26e6906fb8bff  proxmox-ve_6.2-1.iso  #ok!
    
# 2.  Prepare Installation Media  
  see: [Prepare_Installation_Media](https://pve.proxmox.com/wiki/Prepare_Installation_Media)  

## 2.1. Prepare a USB Flash Drive as Installation Medium

The flash drive needs to have at least 1 GB of storage available.
Note 	Do not use UNetbootin. It does not work with the Proxmox VE installation image.
Important 	Make sure that the USB flash drive is not mounted and does not contain any important data.

## 2.2 Instructions for GNU/Linux

On Unix-like operating system use the dd command to copy the ISO image to the USB flash drive. First find the correct device name of the USB flash drive (see below). Then run the dd command.

    dd bs=1M conv=fdatasync if=./proxmox-ve_*.iso of=/dev/XYZ

Note 	Be sure to replace /dev/XYZ with the correct device name and adapt the input filename (if) path.
Caution 	Be very careful, and do not overwrite the wrong disk!
Find the Correct USB Device Name

There are two ways to find out the name of the USB flash drive. The first one is to compare the last lines of the dmesg command output before and after plugging in the flash drive. The second way is to compare the output of the lsblk command. Open a terminal and run:

    lsblk

Then plug in your USB flash drive and run the command again:

    lsblk

A new device will appear. This is the one you want to use. To be on the extra safe side check if the reported size matches your USB flash drive.

## 2.3. Instructions for Manjaro
    sudo pacman -S etcher
    etcher
    lsblk

## 2.4 Instructions for Windows
### 2.4.1 Using Etcher

Etcher works out of the box. Download Etcher from https://etcher.io. It will guide you through the process of selecting the ISO and your USB Drive.

### 2.4.2 Using Rufus

Rufus is a more lightweight alternative, but you need to use the DD mode to make it work. Download Rufus from https://rufus.ie/. Either install it or use the portable version. Select the destination drive and the Proxmox VE ISO file.
Important 	Once you Start you have to click No on the dialog asking to download a different version of GRUB. In the next dialog select the DD mode.
   
  
## 2.5. Boot your Server from the USB Flash Drive

Connect the USB flash drive to your server and make sure that booting from USB is enabled (check your servers firmware settings). Then follow the steps in the installation wizard.



# 3.  Installation proxmox pve
  https://pve.proxmox.com/wiki/Installation  
  

    
    
    
    
  

