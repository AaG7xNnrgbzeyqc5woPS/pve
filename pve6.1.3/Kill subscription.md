

# for pve 6.1.3
## 1, Kill subscription
   
    a) login pve server,  
    b0) cd /usr/share/javascript/proxmox-widget-toolkit/  
    b1) cp proxmoxlib.js proxmoxlib_bak.js  
   
    c0) edit file: /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
    c1) find line:  if (data.status !== 'Active') {
    c2) fixed this line to:  if(false){
       原文如下,请看仔细点:
                    if (data.status !== 'Active') {
                    Ext.Msg.show({
                        title: gettext('No valid subscription'),
                        icon: Ext.Msg.WARNING,
                        message: Proxmox.Utils.getNoSubKeyHtml(data.url),
                        buttons: Ext.Msg.OK,
                        callback: function(btn) {
                            if (btn !== 'ok') {
                                return;
                            }
                            orig_cmd();
                        }
                    });

   
    d) save file
   
    e0) clear browser cookie and cache
    e1) open browser and login pve server again
    e2) now, NO subscription notice at pve web GUI.
   
 ### other way
    a) sed -i 's/.*data.status.*/                if(false){/' proxmoxlib.js
    b) sed -i 's/.*data.status.*/ if(false){  \/\/ hack subscription notify!/' proxmoxlib.js
   
## 2) update pve
  see: https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Stretch  
  
    a) remove pve-enterprise.list
    #rm -f  /etc/apt/sources.list.d/pve-enterprise.list
   
    b) Add the Proxmox VE repository:
    #  echo "deb http://download.proxmox.com/debian/pve stretch pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
   
    c) Add the Proxmox VE repository key: 
    # wget http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg
    # chmod +r /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg  # optional, if you have a changed default umask
   
    d) Update your repository and system by running:
    # apt update && apt dist-upgrade -y
