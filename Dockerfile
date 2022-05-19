FROM ubuntu:latest

ADD roomservice.xml ~/roomservice.xml

RUN sudo apt update && \
    sudo apt upgrade -y && \
    sudo apt install bc bison build-essential ccache curl flex g++-multilib \
    gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev \
    lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev \
    libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip \
    zlib1g-dev python-is-python3 -y && \
    mkdir -p ~/bin && \
    mkdir -p ~/los && \
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && \
    chmod a+x ~/bin/repo && \
    git config --global user.email "you@example.com" && \
    git config --global user.name "Your Name" && \
    cd ~/los && \
    repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-18.1 && \
    mkdir -p .repo/local_manifests && \
    mv ~/roomservice.xml .repo/local_manifests && \
    repo sync -c -j$(nproc --all) && \
    source build/envsetup.sh && \
    lunch lineage_sirius-userdebug && \
    brunch lineage_sirius-userdebug && \
    mv $OUT ~/out && rm -rf ~/los && \
    wget -c https://github.com/sgreben/http-file-server/releases/download/1.6.1/http-file-server_1.6.1_linux_x86_64.tar.gz -O - | tar -xz -C  ~/bin


CMD ~/bin/http-file-server -p $PORT ~/out
