#!/bin/bash
## setup env
sudo apt update && sudo apt upgrade -y
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python-is-python3 -y
mkdir -p ~/bin
mkdir -p ~/los
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
## pull source
cd ~/los
repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-18.1
## pull specific code
mkdir -p .repo/local_manifests
cat << EOF > .repo/local_manifests/roomservice.xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project path="device/xiaomi/sirius" remote="github" name="SDM710-Development/android_device_xiaomi_sirius" />
  <project path="device/xiaomi/sdm710-common" remote="github" name="SDM710-Development/android_device_xiaomi_sdm710-common" />
  <project path="vendor/xiaomi" remote="github" name="SDM710-Development/proprietary_vendor_xiaomi" />
  <project path="kernel/xiaomi/sdm710" remote="github" name="SDM710-Development/android_kernel_xiaomi_sdm710" revision="10.0-caf" />
  <project path="hardware/xiaomi" remote="github" name="LineageOS/android_hardware_xiaomi" />
</manifest>
EOF
repo sync
## start build
source build/envsetup.sh
lunch lineage_sirius-userdebug
brunch lineage_sirius-userdebug
cd $OUT && sudo python http.server 80