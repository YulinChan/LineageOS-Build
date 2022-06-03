## Build ROM for MI8SE SIRIUS

Enviroment：Google Cloud Platforum, ubuntu-latest, 32G RAM, 8 Core CPU, 250G SSD Disk

Of course，the more, the better !

### Install the build packages

Several packages are needed to build LineageOS. You can install these using your distribution’s package manager.

To build LineageOS, you’ll need:

```
sudo apt update && sudo apt upgrade -y
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python-is-python3 -y
```

For Ubuntu versions older than 20.04 (focal), install also:

```
sudo apt install  libwxgtk3.0-dev
```

### Create the directories

You’ll need to set up some directories in your build environment.

To create them:

```
mkdir -p ~/bin
mkdir -p ~/los
```

The `~/bin` directory will contain the git-repo tool (commonly named “repo”) and the `~/los` directory will contain the source code of LineageOS.

### Install the `repo` command

Enter the following to download the `repo` binary and make it executable (runnable):

```
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
```

### Put the `~/bin` directory in your path of execution

In recent versions of Ubuntu, `~/bin` should already be in your PATH. You can check this by opening `~/.profile` with a text editor and verifying the following code exists (add it if it is missing):

```
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
```

Then, run `source ~/.profile` to update your environment.

### Configure git

Given that `repo` requires you to identify yourself to sync Android, run the following commands to configure your `git` identity:

```
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

### Turn on caching to speed up build

Make use of [`ccache`](https://ccache.samba.org/) if you want to speed up subsequent builds by running:

```
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
```

and adding that line to your `~/.bashrc` file. Then, specify the maximum amount of disk space you want `ccache` to use by typing this:

```
ccache -M 25G
```

This space will be permanently occupied on your drive, so take this into consideration.

You can also enable the optional `ccache` compression. While this may involve a slight performance slowdown, it increases the number of files that fit in the cache. To enable it, run:

```
ccache -o compression=true
```

**NOTE:** If compression is enabled, the `ccache` size can be lower (aim for approximately 20GB for one device).

### Initialize the LineageOS source repository

```
cd ~/los
repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-18.1
```

### Download the source code

To start the download of the source code to your computer, type the following:

```
repo sync
```

The LineageOS manifests include a sensible default configuration for repo, which we strongly suggest you use (i.e. don’t add any options to sync). For reference, our default values are `-j 4` and `-c`. The `-j 4` part implies be four simultaneous threads/connections. If you experience problems syncing, you can lower this to `-j 3` or `-j 2`. On the other hand, `-c` makes repo to pull in only the current branch instead of all branches that are available on GitHub.

**NOTE:** This may take a while, depending on your internet speed. Go and have a beer/coffee/tea/nap in the meantime!

**TIP:** The `repo sync` command is used to update the latest source code from LineageOS and Google. Remember it, as you may want to do it every few days to keep your code base fresh and up-to-date. But note, if you make any changes, running `repo sync` may wipe them away!

### Prepare the device-specific code

After the source downloads, ensure you’re in the root of the source code (`cd ~/los`), then type:

```
mkdir -p .repo/local_manifests
cat << EOF > .repo/local_manifests/roomservice.xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project path="device/xiaomi/sirius" remote="github" name="SDM710-Development/android_device_xiaomi_sirius" />
  <project path="device/xiaomi/sdm710-common" remote="github" name="SDM710-Development/android_device_xiaomi_sdm710" />
  <project path="vendor/xiaomi" remote="github" name="SDM710-Development/proprietary_vendor_xiaomi" />
  <project path="kernel/xiaomi/sdm710" remote="github" name="SDM710-Development/android_kernel_xiaomi_sdm710" revision="10.0-caf" />
  <project path="hardware/xiaomi" remote="github" name="LineageOS/android_hardware_xiaomi" />
</manifest>                                                                            EOF
repo sync
```

This will download your device’s device specific configuration , vendor and kernel 

We can also do it manually:

```
git clone <github.repo.device> device/xiaomi/sirius
git clone <github.repo.kernel> kernel/xiaomi/sirius
git clone <github.repo.vendor> vendor/xiaomi/sirius
git clone <github.repo.hardware> hardware/xiaomi/sirius
```

### Start the build

**Note：LineageOS already has a sony phone call sirius, we need do something to avoid conflict !  Use lunch first and the brunch **

Time to start building! Now, type:

```
source build/envsetup.sh
lunch  lineage_sirius-userdebug
brunch lineage_sirius-userdebug
```

The build should begin.

## Install the build

Assuming the build completed without errors (it will be obvious when it finishes), type the following in the terminal window the build ran in:

```
cd $OUT
```

There you’ll find all the files that were created. The two files of more interest are:

1. `recovery.img`, which is the LineageOS recovery image.
2. `lineage-18.1-20220515-UNOFFICIAL-sirius.zip`, which is the LineageOS installer package.

### References

[How to build an unsupported rom using sources from other roms](https://forum.xda-developers.com/t/guide-how-to-build-an-unsupported-rom-using-sources-from-other-roms.3844972/)

[如何自己编译自定义 Android ROM](https://blog.779.moe/archives/3/)

[LineageOS 17 - Youtube](https://www.youtube.com/playlist?list=PLRJ9-cX1yE1nTL6cuJszmdJOAS2918mrh)

[LineageOS Wiki Build for dipper](https://wiki.lineageos.org/devices/dipper/build)

[Adding branch tag to local_manifest.xml](https://forum.xda-developers.com/t/q-adding-branch-tag-to-local_manifest-xml.3766237/)
