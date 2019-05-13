# filename: pve_init.sh
# url: 
# first pve init config shell script
#for pve 5.4-3
# 1, kill subsciption notify
# 2, update pve
# writed at 2019.5.13 

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
