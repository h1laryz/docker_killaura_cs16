FROM ubuntu:24.10

# Preparing OS
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y sudo wget unzip curl apt-utils dotnet-sdk-9.0 dnsutils \
    screen nano file tar bzip2 gzip unzip hostname bsdmainutils python3 \
    util-linux xz-utils ca-certificates binutils bc jq tmux netcat-traditional \
    lib32stdc++6 distro-info lib32gcc-s1 && \
    rm -rf /var/lib/apt/lists/*

# Copy scripts
WORKDIR /scripts
COPY start_server_entrypoint.sh ./start.sh
COPY update_server_entrypoint.sh ./update.sh
RUN chmod +x start.sh && chmod +x update.sh
ENV PATH="/scripts/:$PATH"

# Creating user -> container
RUN useradd -m -s /bin/bash container && \
    usermod -aG sudo container

# Installing SteamCMD -> container + root
RUN mkdir -p /opt/steamcmd && \
    cd /opt/steamcmd && \
    wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz && \
    mkdir -p /home/container/.steam/sdk32 && \
    mkdir -p /home/container/.steam/sdk64 && \
    ln -s /opt/steamcmd/linux32/steamclient.so /home/container/.steam/sdk32/steamclient.so && \
    ln -s /opt/steamcmd/linux64/steamclient.so /home/container/.steam/sdk64/steamclient.so && \
    chmod -R 775 /opt/steamcmd && \
    chgrp -R container /opt/steamcmd && \
    chown -R 1001:1001 /home/container/.steam
ENV PATH="/opt/steamcmd:$PATH"

# Login as user -> container
USER container
WORKDIR /home/container

# Run update if start is not passed
CMD ["bash", "-c", "update.sh && start.sh"]