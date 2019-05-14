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

#My shell script skill update, Now can use funciton.


function hack_pve_subscription()
{
  echo "-----kill subscription notify-----"
  echo " ---only test for pve 5.4-3 --- "
  
  fpve_js_path="/usr/share/javascript/proxmox-widget-toolkit/"
  cd ${fpve_js_path}

  js0="proxmoxlib.js"
  js_bak="proxmoxlib_bak.js"
  
  if [ -e ${js0} ]
  then
    echo Exist ${js0}, OK!
  else
    echo No Exist ${js0}, Error!
    return -1
  fi
  
  if [ -e ${js_bak} ]
  then
    echo Exist ${js_bak} file already
  else
    echo No exist ${js_bak} file!
    cp -n ${js0} ${js_bak}
    echo Now copy ${js0} to ${js_bak}

    # sed -i 's/.*data.status.*/ if(false){/' proxmoxlib.js
    sed -i 's/.*data.status.*/ if(false){ \/\/ hack subscription notify!/' ${js0}
    echo Hack ${js0} OK!
  fi

  cd
  return 0
}

function update_pve()
{
  echo "update pve"
  
  local list_path="/etc/apt/sources.list.d/"
  local entlist="pve-enterprise.list"
  local repolist="pve-install-repo.list"
  local item_repo="deb http://download.proxmox.com/debian/pve stretch pve-no-subscription"
  
  cd list_path
  if [ -e ${entlist} ]
  then
    rm -f ${entlist}  
    echo item_repo > ${repolist}
  
    cd
    
    wget http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg
    chmod +r /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg # optional, if you have a changed default umask
  fi
  
  return 0
}

function upgrade()
{
  apt update && apt dist-upgrade -y
  return 0
}

hack_pve_subscription
