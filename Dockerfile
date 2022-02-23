FROM ubuntu:20.04 as build

# ref:
# ref: https://github.com/mdegans/docker-tegra-ubuntu/blob/l4t-base/build_all.sh
# https://github.com/balena-io-library/base-images/tree/master/balena-base-images/device-base
# https://forums.balena.io/t/getting-linux-for-tegra-into-a-container-on-balena-os/179421/20

# jetson nano, and tx1.
# 194 = xavier
# 186 = tx2
ARG SOC=t210

ENV DEBIAN_FRONTEND=noninteractive

ADD --chown=root:root https://repo.download.nvidia.com/jetson/jetson-ota-public.asc /etc/apt/trusted.gpg.d/jetson-ota-public.asc
RUN chmod 644 /etc/apt/trusted.gpg.d/jetson-ota-public.asc \
    && apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
    && echo "deb https://repo.download.nvidia.com/jetson/common r32.5 main" > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list \
    && echo "deb https://repo.download.nvidia.com/jetson/${SOC} r32.5 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list \
    && apt-get update \
    && rm -rf /var/lib/apt/lists/*

ADD http://http.us.debian.org/debian/pool/main/libf/libffi/libffi6_3.2.1-9_arm64.deb /opt/
RUN dpkg -i /opt/libffi6_3.2.1-9_arm64.deb
RUN mkdir -p /opt/nvidia/l4t-packages/ && \
    touch /opt/nvidia/l4t-packages/.nv-l4t-disable-boot-fw-update-in-preinstall

RUN apt-get -qq update && \
    apt-get install --no-install-recommends -y \
      nvidia-l4t-core \
      nvidia-l4t-multimedia \
      nvidia-l4t-multimedia-utils \
      nvidia-l4t-cuda \
      nvidia-l4t-3d-core \
      nvidia-l4t-wayland \
      nvidia-l4t-x11 \
      nvidia-l4t-firmware \
      nvidia-l4t-tools

# tag as cptnalf/ubuntu-jetson:20.04
