#!/bin/bash

# some shit without it doesn't work idk (steam = shit)
if [ -z "$BITS" ]; then
    # Determine the operating system architecture
    architecture=$(uname -m)

    # Set OS_BITS based on the architecture
    if [[ $architecture == *"64"* ]]; then
        export BITS=64
    elif [[ $architecture == *"i386"* ]] || [[ $architecture == *"i686"* ]]; then
        export BITS=32
    else
        echo "Unknown architecture: $architecture"
        exit 1
    fi
fi

echo "Shit happening..."
# https://developer.valvesoftware.com/wiki/Command_line_options
steamcmd.sh \
	+api_logging 1 1 \
	+@sSteamCmdForcePlatformType linux \
	+@sSteamCmdForcePlatformBitness $BITS \
	+login anonymous \
	+quit

echo "/home/container/cs/hlds_run \
    -dedicated \
    -console \
    -game cstrike \
    -port 27015 \
    +map $KILLAURA_CS16_DEFAULT_MAP \
    $KILLAURA_CS16_LAUNCH_PARAMS"

cd /home/container/cs/
./hlds_run \
    -dedicated \
    -console \
    -game cstrike \
    -port 27015 \
    +map $KILLAURA_CS16_DEFAULT_MAP \
    $KILLAURA_CS16_LAUNCH_PARAMS
