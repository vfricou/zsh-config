#!/bin/zsh
# BATDIR is the folder with your battery characteristics
BATDIR="/sys/class/power_supply/BAT0"
ACSTAT=$(cat /sys/class/power_supply/AC/online)

max=`cat $BATDIR/charge_full`
current=`cat $BATDIR/charge_now`
percent=$(( 100 * $current / $max ))

if [ -n ${ACSTAT} ]
then
	if [ ${ACSTAT} != "1" ]
	then
		echo "($percent%%)"
	fi
fi
