# 1, Kill subscription
- a) login pve server, 
- 
- b0) cd /usr/share/javascript/proxmox-widget-toolkit/
- b1) cp proxmoxlib.js proxmoxlib_bak.js
-   
- c0) edit file: /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
- c1) find line 1 :  if (res === null || res === undefined || !res || res
- c2) find line 2 :    .data.status.toLowerCase() !== 'active') {
- c2) fixed there lines to:  if (false) {
```
                    // if (res === null || res === undefined || !res || res  // Comment by John at 2023.5.23
                    //  .data.status.toLowerCase() !== 'active') {           // Comment by John at 2023.5.23
                    if (false) {                                             // Add by John at 2023.5.23
```
-   
- d) save file
-  
- e0) clear browser cookie and cache
- e1) open browser and login pve server again
- e2) now, NO subscription notice at pve web GUI.

# 2. Tesk OK!
