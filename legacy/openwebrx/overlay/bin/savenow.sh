#!/bin/sh
## Set commands
. /bin/readsettings.sh
echo "Changes saved here will take effect now and persist across reboots."
echo "If you (re)flash the PlutoSDR you will lose your settings."
read -p "Do you want to save the current settings to NVRAM? (y/n): " yn
case $yn in
	[Yy]* ) 
echo "Wait while writing to NVRAM..."
fw_setenv center_freq $center_freq
fw_setenv start_freq $start_freq
fw_setenv samp_rate $samp_rate
fw_setenv start_mod $start_mod
fw_setenv rf_gain $rf_gain
fw_setenv ppm $ppm
echo "Done."
exit;;
	* ) exit;;
esac
