<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# root@pve2:~\# zpool create tank mirror

invalid vdev specification: mirror requires at least 2 devices
root@pve2:~\# lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda           8:0    0   1.8T  0 disk
├─sda1        8:1    0   1.8T  0 part
└─sda9        8:9    0     8M  0 part
sdb           8:16   0   1.8T  0 disk
├─sdb1        8:17   0   1.8T  0 part
└─sdb9        8:25   0     8M  0 part
nvme0n1     259:0    0 953.9G  0 disk
├─nvme0n1p1 259:1    0  1007K  0 part
├─nvme0n1p2 259:2    0     1G  0 part
└─nvme0n1p3 259:3    0 952.9G  0 part
root@pve2:~\# zpool create tank mirror /dev/sda /dev/sdb
invalid vdev specification
use '-f' to override the following errors:
/dev/sda1 is part of potentially active pool 'tank'
/dev/sdb1 is part of potentially active pool 'tank'
root@pve2:~\# zpool create tank mirror /dev/sda1 /dev/sdb1
invalid vdev specification
use '-f' to override the following errors:
/dev/sda1 is part of potentially active pool 'tank'
/dev/sdb1 is part of potentially active pool 'tank'
root@pve2:~\# zpool online /dev/sda1 /dev/sdb1
cannot open '/dev/sda1': invalid character '/' in pool name
root@pve2:~\# zpool online tank /dev/sda1 /dev/sdb1
cannot open 'tank': no such pool
root@pve2:~\#

The errors and issues you are encountering when trying to create or manage the ZFS pool "tank" stem from the fact that the devices (/dev/sda1 and /dev/sdb1) are already part of an existing or potentially active pool named "tank." This prevents you from creating a new pool with the same devices or bringing them online in a new pool without first properly handling the existing pool configuration.

### Explanation of the errors:

1. **"invalid vdev specification: mirror requires at least 2 devices"**
This error occurs when you run `zpool create tank mirror` without specifying any devices. A mirror vdev requires at least two devices to be specified explicitly.
2. **"invalid vdev specification ... use '-f' to override the following errors: /dev/sda1 is part of potentially active pool 'tank'"**
This means the partitions /dev/sda1 and /dev/sdb1 are already part of a pool named "tank" that is either active or marked as potentially active. ZFS prevents you from reusing these devices without forcing the operation.
3. **"cannot open 'tank': no such pool" and "cannot open '/dev/sda1': invalid character '/' in pool name"**
These errors occur because the `zpool online` command syntax requires the pool name first, then the device, and you cannot specify devices directly without a pool context. Also, `/dev/sda1` is a device path, not a pool name.

### How to resolve these issues:

#### Step 1: Check if the pool "tank" exists or is imported

Run:

```bash
zpool import
```

This will list any pools available for import, including "tank" if it is not currently imported.

If "tank" appears, import it with:

```bash
zpool import tank
```

If the pool is imported successfully, you can then manage it (e.g., bring devices online, export it, or destroy it).

#### Step 2: If the pool "tank" is corrupted or unusable and you want to destroy it:

You must destroy the existing pool before re-creating it. To do so, use the force option if necessary:

```bash
zpool destroy -f tank
```

This will remove the pool "tank" and free the devices for reuse.

#### Step 3: If the pool is not imported but devices are still marked as part of "tank":

You can try to clear the ZFS labels on the devices to remove the pool metadata:

```bash
zpool labelclear -f /dev/sda1
zpool labelclear -f /dev/sdb1
```

This will wipe the ZFS metadata from the partitions, allowing you to create a new pool without the `-f` force option.

#### Step 4: Create the new mirrored pool properly

Once the devices are free from previous pool metadata, create the mirror pool with:

```bash
zpool create tank mirror /dev/sda1 /dev/sdb1
```

If you want to force creation despite warnings, you can add `-f`:

```bash
zpool create -f tank mirror /dev/sda1 /dev/sdb1
```

Make sure to specify partitions or whole disks consistently.

### Additional notes:

- The `zpool online` command is used to bring devices online in an existing pool, not to create pools or manage devices outside of a pool context.
- Using `-f` forces operations but should be used carefully to avoid data loss.
- If the pool is stuck in a "potentially active" state, it may be because the system thinks it's still in use or was not cleanly exported. Properly importing or destroying the pool clears this state.


### Summary of commands you likely need:

```bash
# Check for existing pools
zpool import

# If 'tank' exists and you want to import it
zpool import tank

# If you want to destroy the existing 'tank' pool
zpool destroy -f tank

# Clear ZFS labels from devices if needed
zpool labelclear -f /dev/sda1
zpool labelclear -f /dev/sdb1

# Create new mirror pool
zpool create tank mirror /dev/sda1 /dev/sdb1
```

This approach aligns with best practices and common solutions to similar errors reported in ZFS pool creation and management[^3][^7][^5][^2][^6].

<div style="text-align: center">⁂</div>

[^1]: https://unix.stackexchange.com/questions/478399/how-do-i-create-zfs-pool-with-4-drives-and-mirrors

[^2]: https://bobcares.com/blog/zpool-create-vdev/

[^3]: https://docs.oracle.com/cd/E19253-01/819-5461/gazhs/index.html

[^4]: https://docs.oracle.com/cd/E19253-01/819-5461/gazgk/index.html

[^5]: https://www.reddit.com/r/zfs/comments/1bd4ipi/no_pool_available_pool_online_readonly_access/

[^6]: https://briankoopman.com/moving/

[^7]: https://docs.oracle.com/cd/E19253-01/819-5461/gaypw/index.html

[^8]: https://openzfs.github.io/openzfs-docs/man/master/8/zpool-online.8.html

[^9]: https://docs.oracle.com/cd/E19253-01/819-5461/gbbvb/index.html

[^10]: https://blog.programster.org/zfs-create-disk-pools

[^11]: https://man.freebsd.org/cgi/man.cgi?query=zpool-online(8)

[^12]: https://www.manpagez.com/man/8/zpool/

[^13]: https://forums.freebsd.org/threads/the-correct-way-create-a-zfs-mirror-pool.91782/

[^14]: https://forum.proxmox.com/threads/first-steps-to-create-a-zfs-mirror.156370/

[^15]: https://www.reddit.com/r/zfs/comments/a5jdkp/help_trying_to_recreate_an_existing_pool/

[^16]: https://forums.freebsd.org/threads/unable-to-create-new-zfs-pool-with-nvme-ssd.89060/

[^17]: https://openzfsonosx.org/forum/viewtopic.php?f=26\&t=3032

[^18]: https://docs.oracle.com/cd/E19253-01/819-5461/gazgm/index.html

[^19]: https://openzfs.github.io/openzfs-docs/man/8/zpool.8.html

[^20]: https://docs.oracle.com/cd/E19253-01/819-5461/gavwn/index.html

[^21]: https://discourse.practicalzfs.com/t/zpool-create-should-i-attempt-to-get-the-documentation-changed/1529

[^22]: https://www.reddit.com/r/zfs/comments/10p07yj/adding_mirroring_disk_to_a_single_disk_zpool/

[^23]: https://superuser.com/questions/488662/can-two-seperate-zpools-exist-on-the-same-physical-devices

[^24]: https://github.com/openzfs/zfs/issues/11087

[^25]: https://docs.oracle.com/cd/E19253-01/819-5461/6n7ht6qvi/index.html

[^26]: https://askubuntu.com/questions/917929/how-to-recover-zfs-pool-with-errors-that-disappeared-after-reboot

[^27]: https://serverfault.com/questions/586782/zpool-status-reports-error-what-next

[^28]: https://docs.huihoo.com/opensolaris/solaris-zfs-administration-guide/html/ch04s03.html

[^29]: https://askubuntu.com/questions/172577/replacing-a-disk-in-zpool

[^30]: https://unix.stackexchange.com/questions/207255/zpool-online-doesnt-work

