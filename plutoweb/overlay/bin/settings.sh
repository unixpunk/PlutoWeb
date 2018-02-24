#!/bin/sh
## Set commands
. /bin/readsettings.sh
echo "Changes made here will take effect now and persist across reboots."
echo "If you (re)flash the PlutoSDR you will lose your settings."
read -p "Do you want to change these settings? (y/n): " yn
case $yn in
	[Yy]* ) 
echo "If you make a mistake, CTRL+C to exit and then start over."
read -p "Enter the new center frequency (70000000-6000000000): [460250000] " center_freq
read -p "Enter the new starting frequency (70000000-6000000000): [460152000] " start_freq
read -p "Enter the new sample rate (65105-10000000): [600000] " samp_rate
read -p "Enter the new starting demodulator (nfm,am,lsb,usb,cw): [nfm] " start_mod
read -p "Enter the new RF gain in dB (0-89): [89] " rf_gain
read -p "Enter the new PPM adjustment: [0] " ppm
echo "Writting settings to temp file..."
echo "center_freq=$center_freq" >/root/temp-settings
echo "start_freq=$start_freq" >>/root/temp-settings
echo "samp_rate=$samp_rate" >>/root/temp-settings
echo "start_mod=$start_mod" >>/root/temp-settings
echo "rf_gain=$rf_gain" >>/root/temp-settings
echo "ppm=$ppm" >>/root/temp-settings
echo "Wait while writing to NVRAM..."
fw_setenv center_freq $center_freq
fw_setenv start_freq $start_freq
fw_setenv samp_rate $samp_rate
fw_setenv start_mod $start_mod
fw_setenv rf_gain $rf_gain
fw_setenv ppm $ppm
echo "Done.  Restarting OpenwebRx now..."
/etc/init.d/S95openwebrx stop
/etc/init.d/S95openwebrx start
exit;;
	* ) exit;;
esac
