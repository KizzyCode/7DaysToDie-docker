#!/usr/bin/bash
set -eu

# Export CPU frequency if necessary
if ! test -e "/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq"; then
    export CPU_MHZ=${CPU_MHZ:-1600}
fi

# Install/update 7 Days to Die
/usr/games/steamcmd \
    +@sSteamCmdForcePlatformBitness 64 \
    +force_install_dir "$HOME/app" \
    +login anonymous \
    +app_update 294420 \
    +quit

# Execute server
export LD_LIBRARY_PATH="$HOME/app/7DaysToDieServer.x86_64"
exec "$HOME/app/7DaysToDieServer.x86_64" \
    -configfile="$HOME/data/serverconfig.xml" \
    -quit -batchmode -nographics -dedicated
