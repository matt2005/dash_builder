# Development Enviroment

## steps

### Debian
```bash
$ sudo apt-get install binfmt-support fdisk file kpartx lsof parted qemu qemu-user-static unzip p7zip-full wget xz-utils
```

```
git clone https://github.com/Nature40/pimod.git
cd pimod
git clone https://github.com/matt2005/dash_builder.git
cd dash_builder
sudo ./../pimod.sh base_bullseye_armhf.Pifile
sudo ./../pimod.sh opendsh_bullseye_armhf.Pifile
```
