# DASH_BUILDER

Dash_Builder uses the github action Nature40/pimod to build the images.

## Process
The below process is performed on both armhf and arm64. This takes about 3hours to build via github actions.

### Build Base Image

1. Get RPI Debian Lite image
1. Increase Image by 2000MB
1. Update image

### Build OpenDsh Image

1. Get Base Image
1. Install packages required for Lite OS
1. Clone dash repo
1. Setup Dash


### Docker build
```bash
docker run --rm --privileged \
    -v $PWD:/files \
    -e PATH=/pimod:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    --workdir=/files \
    nature40/pimod \
    pimod.sh /files/base_bullseye_armhf.pifile
mv base_bullseye_armhf.pifile.img base_bullseye_armhf.img
docker run --rm --privileged \
    -v $PWD:/files \
    -e PATH=/pimod:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    --workdir=/files \
    nature40/pimod \
    pimod.sh /files/compile_bullseye_armhf.pifile
mv compile_bullseye_armhf.pifile.img compile_bullseye_armhf.img
docker run --rm --privileged \
    -v $PWD:/files \
    -e PATH=/pimod:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    --workdir=/files \
    nature40/pimod \
    pimod.sh /files/final_bullseye_armhf.pifile
mv final_bullseye_armhf.pifile.img final_bullseye_armhf.img
```
## Credits

@matt2005
@icecube45
