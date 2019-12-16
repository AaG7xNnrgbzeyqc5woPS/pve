1.  迁移到 Proxmox VE

从别的虚拟化方案（XenServer, ESXi 等）迁移到 PVE 也不难。
总体思路就是获取到虚拟磁盘（需要是 qemu-img 支持的格式，如 raw, vhd, qcow2, vmdk 等），
然后像上文导入 Cloud Image 那样导入 PVE 即可。

由于半虚拟化驱动的不同，部分情况下 VM 可能会无法启动（找不到磁盘），
为了避免不必要的麻烦，建议在迁移前先在旧系统里将 initramfs 的生成配置改为
generic / fallback 或其他类似设置，使其包含所有的存储驱动，
以便在各种虚拟化方案里都能成功启动。
