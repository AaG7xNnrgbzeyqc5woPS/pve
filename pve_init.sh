#!/bin/bash
#--------------------------------------------------
# filename: pve_init.sh
# url: https://github.com/AaG7xNnrgbzeyqc5woPS/pve/blob/master/pve_init.sh
# first pve init config shell script
#for pve 5.4-3
# 1, kill subsciption notify
# 2, update pve
# writed at 2019.5.13 

#------------------------------
#use shell:
#wget https://raw.githubusercontent.com/AaG7xNnrgbzeyqc5woPS/pve/master/pve_init.sh
#chmod +x pve_init.sh && ./pve_init.sh

#Now login pve GUI console from firefox with url: https://pveurl:8006
#if have subsription notify ,please  clear firefox cache buffer. 

#----------------------------------------------
#to do list:
# 1, if pve server is run this scription already.
# then run this scription again, must jump to end.
# 2, update,upgrade speed is very slower, must update connect with v2ray proxy.
# --2019.5.14

echo "kill subsciption notify"
cd /usr/share/javascript/proxmox-widget-toolkit/
cp -n proxmoxlib.js proxmoxlib_bak.js

# sed -i 's/.*data.status.*/ if(false){/' proxmoxlib.js
sed -i 's/.*data.status.*/ if(false){ \/\/ hack subscription notify!/' proxmoxlib.js

echo "update pve"
cd 
rm -f /etc/apt/sources.list.d/pve-enterprise.list
echo "deb http://download.proxmox.com/debian/pve stretch pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
wget http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg
chmod +r /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg # optional, if you have a changed default umask
apt update && apt dist-upgrade -y
