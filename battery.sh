#!/bin/zsh
# BATDIR is the folder with your battery characteristics
BATDIR="/sys/class/power_supply/BAT0"
max=`cat $BATDIR/charge_full`
current=`cat $BATDIR/charge_now`
percent=$(( 100 * $current / $max ))
echo "($percent%%)"
