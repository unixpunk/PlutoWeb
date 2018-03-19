#!/bin/sh
. /bin/readsettings.sh
echo "Changes saved here will take effect now and persist across reboots."
echo "If you (re)flash the PlutoSDR you will lose your settings."
if [ "$1" = "yes" ]; then
	yn=y
elif [ "$1" = "erase" ]; then
	echo "Wait while erasing settings from NVRAM..."
	fw_setenv autostart
	fw_setenv autoreboot
	fw_setenv autoupdate
	fw_setenv center_freq
	fw_setenv start_freq
	fw_setenv samp_rate
	fw_setenv start_mod
	fw_setenv rf_gain
	fw_setenv ppm
	echo "Done."
	exit
else
	read -p "Do you want to save the current settings to NVRAM? (y/n): " yn
fi
case $yn in
	[Yy]* ) 
echo "Wait while writing to NVRAM..."
fw_setenv autostart $autostart
fw_setenv autoreboot $autoreboot
fw_setenv autoupdate $autoupdate
fw_setenv center_freq $center_freq
fw_setenv start_freq $start_freq
fw_setenv samp_rate $samp_rate
fw_setenv start_mod $start_mod
fw_setenv rf_gain $rf_gain
fw_setenv ppm $ppm
echo "Done."
exit;;
esac
read -p "Do you want to erase all settings from NVRAM? (y/n): " yn2
case $yn2 in
	[Yy]* )
	echo "Wait while erasing settings from NVRAM..."
        fw_setenv autostart
	fw_setenv autoreboot
	fw_setenv autoupdate
	fw_setenv center_freq
	fw_setenv start_freq
	fw_setenv samp_rate
	fw_setenv start_mod
	fw_setenv rf_gain
	fw_setenv ppm
        echo "Done."
	exit;;
esac
