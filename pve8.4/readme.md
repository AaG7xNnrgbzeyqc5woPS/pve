# zpool
```
zpool status tank
zpool status
zpool status -v
zpool scrub tank
zpool clear tank

```

# Run an Extended SMART Self-Test
Run an Extended SMART Self-Test   
To check for latent issues:
```
smartctl -t long /dev/sdb
```
After completion (about 5 hours), check results:
```
smartctl -a /dev/sdb
```
