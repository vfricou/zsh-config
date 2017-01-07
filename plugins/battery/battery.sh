#!/bin/zsh
# BATDIR is the folder with your battery characteristics
BATDIR="/sys/class/power_supply/BAT0"
ACSTAT=$(cat /sys/class/power_supply/AC0/online)

max=`cat $BATDIR/energy_full`
current=`cat $BATDIR/energy_now`
percent=$(( 100 * $current / $max ))

if [ -n ${ACSTAT} ]
then
	if [ ${ACSTAT} != "1" ]
	then
		echo "($percent%%)"
	fi
fi
