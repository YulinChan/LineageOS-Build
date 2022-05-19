FROM ubuntu:latest

ADD build.sh /opt/build.sh

RUN sudo apt update && \
    sudo apt upgrade -y && \
    sudo apt install bc bison build-essential ccache curl flex g++-multilib \
    gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev \
    lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev \
    libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip \
    zlib1g-dev python-is-python3 -y && \
    chmod +x /opt/build.sh

ENTRYPOINT ["sh", "-c", "/opt/build.sh"]
