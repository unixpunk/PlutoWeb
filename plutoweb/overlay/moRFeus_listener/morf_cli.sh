#!/bin/sh

morf_tool_dir=/moRFeus_listener
morf_tool=/bin/morfeus_tool_linux_armv7


source $morf_tool_dir/get_status.sh

#######

echo "


*** moRFeus remote control
*** LamaBleu 05/2018


moRFeus listener commands :
-----------------------

S		: Show Status
F 123456789	: Set Frequency (hz) = (85000000-5400000000)
M [n]		: Mixer Mode [Power = (0-7)]
G [n]		: Generator Mode [Power = (0-7)]
P n 		: Power = (0-7)
Q or X		: Disconnect
KK		: Kill Server
"

get_status


while :
do
command=""
freq=""
arg1=""
power=""
mode=""

read -r morf_com


command=$(echo $morf_com | awk '{print $1}')
arg1=$(echo $morf_com | awk '{print $2}')
arg1=${arg1//[![:digit:]]}

power=$($morf_tool getCurrent)

case $command in
	[Ff]) echo "    **** setFrequency $arg1"
		if [ -z "$arg1" ]; then arg1=""; fi
		$morf_tool setFrequency $((arg1)); arg1=""
		get_status;
		;;
	[XxQq]) echo "       **** DISCONNECT "
		echo "       Goodbye. "
		exit 0;
		;;
	[Ss]) get_status;
		;;
	KK) echo "Disconnect and kill server - Goodbye forever !"
		killall socat
		exit 0;
		;;
	[Mm]) if [ -z "$arg1" ]; then arg1=$power; fi
		echo "    **** set Mixer mode  - Power $arg1"
		$morf_tool Mixer
		$morf_tool setCurrent $((arg1))
		get_status;
		;;
	[Pp]) if [ -z "$arg1" ]; then arg1=$power; fi
		echo "    **** set Current  - Power $arg1"
		$morf_tool setCurrent $((arg1))
		get_status;
		;;
	[Gg]) if [ -z "$arg1" ]; then arg1=$power; fi
		echo "    **** set Generator mode  - Power $arg1"
		$morf_tool Generator
		$morf_tool setCurrent $((arg1))
		get_status;
		;;
	*) command=""
		freq=""
		morf_com=""
		arg1=""
		get_status;
		;;
esac


command=""
freq=""
morf_com=""
arg1=""

done


