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

# 2. new keyword
```
Ext.Msg.show({
                            title: gettext('No valid subscription'),
                            icon: Ext.Msg.WARNING,
                            message: Proxmox.Utils.getNoSubKeyHtml(res.data.url),
                            buttons: Ext.Msg.OK,

```
❤️```No valid subscription``` at lines 568 of  proxmoxlib.js in pve 8.4 -- 2025-5-15

# 3.❤️ 跳过 checked_command 函数
- 备份 /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js 文件
- 根据关键字 ```'No valid subscription'``` 找到   checked_command: function(orig_cmd)  函数
- 使用多行注释符 ```/*   */``` 注释掉该函数
- 重新编写一个新函数如下：
  ```
   // fixed by John 2025-6-10
   checked_command: function(orig_cmd) {
        orig_cmd();
   },

  ```
  - 保存文件proxmoxlib.js
  - clear browser cookie and cache
  - now, NO subscription notice at pve web GUI.
  -  2025-6-10， pve 8.4.1 TEST OK!
