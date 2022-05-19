#!/bin/sh
## setup env
wget https://github.com/sgreben/http-file-server/releases/download/1.6.1/http-file-server_1.6.1_linux_x86_64.tar.gz
tar xvf http-file-server_1.6.1_linux_x86_64.tar.gz
mv http-file-server /opt
chmod +x /opt/http-file-server
/opt/http-file-server -p $PORT /opt
# curl https://storage.googleapis.com/git-repo-downloads/repo > /home/bin/repo
# chmod a+x /home/bin/repo
# if [ -d "/home/bin" ] ; then
#     PATH="/home/bin:$PATH"
# fi
# git config --global user.email "you@example.com"
# git config --global user.name "Your Name"
# ## pull source
# cd /home/los
# repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-18.1
# ## pull specific code
# mkdir -p .repo/local_manifests
# cat << EOF > .repo/local_manifests/roomservice.xml
# <?xml version="1.0" encoding="UTF-8"?>
# <manifest>
#   <project path="device/xiaomi/sirius" remote="github" name="SDM710-Development/android_device_xiaomi_sirius" />
#   <project path="device/xiaomi/sdm710-common" remote="github" name="SDM710-Development/android_device_xiaomi_sdm710-common" />
#   <project path="vendor/xiaomi" remote="github" name="SDM710-Development/proprietary_vendor_xiaomi" />
#   <project path="kernel/xiaomi/sdm710" remote="github" name="SDM710-Development/android_kernel_xiaomi_sdm710" revision="10.0-caf" />
#   <project path="hardware/xiaomi" remote="github" name="LineageOS/android_hardware_xiaomi" />
# </manifest>
# EOF
# repo sync
# ## start build
# source build/envsetup.sh
# lunch lineage_sirius-userdebug
# brunch lineage_sirius-userdebug
# mv $OUT/*.zip /home/bin