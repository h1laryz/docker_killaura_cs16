#!/bin/bash

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

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
FREE_SPACE=$(df / --output=avail -BG | tail -n 1 | tr -d 'G')

echo "With $FREE_SPACE Gb free space..."

echo "Downloading any updates for cs 1.6"
# https://developer.valvesoftware.com/wiki/Command_line_options
steamcmd.sh \
	+api_logging 1 1 \
	+@sSteamCmdForcePlatformType linux \
	+@sSteamCmdForcePlatformBitness $BITS \
	+force_install_dir ~/cs \
	+login anonymous \
    +app_set_config 90 mod cstrike \
	+app_update 90 -beta steam_legacy validate \
	+quit
