#!/bin/sh
. /bin/readsettings.sh
flash_indication_on() {
        echo timer > /sys/class/leds/led0:green/trigger
        echo 40 > /sys/class/leds/led0:green/delay_off
        echo 40 > /sys/class/leds/led0:green/delay_on
}

flash_indication_off() {
        echo heartbeat > /sys/class/leds/led0:green/trigger
}

write_all() {
        fw_printenv qspiboot
        if [ $? -eq 0 ]; then
                flash_indication_on
                echo "Wait while writing to NVRAM..."
                echo "autostart $autostart" >/opt/fw_set.tmp
                echo "autoreboot $autoreboot" >> /opt/fw_set.tmp
                echo "autoupdate $autoupdate" >> /opt/fw_set.tmp
                echo "center_freq $center_freq" >> /opt/fw_set.tmp
                echo "start_freq $start_freq" >> /opt/fw_set.tmp
                echo "samp_rate $samp_rate" >> /opt/fw_set.tmp
                echo "start_mod $start_mod" >> /opt/fw_set.tmp
                echo "rf_gain $rf_gain" >> /opt/fw_set.tmp
                echo "ppm $ppm" >> /opt/fw_set.tmp
                fw_setenv -s /opt/fw_set.tmp
                rm /opt/fw_set.tmp
                echo "Done."
                flash_indication_off
        fi
}

erase_all() {
        fw_printenv qspiboot
        if [ $? -eq 0 ]; then
                flash_indication_on
                echo "Wait while erasing settings from NVRAM..."
                echo autostart >/opt/fw_set.tmp
                echo autoreboot >>/opt/fw_set.tmp
                echo autoupdate >>/opt/fw_set.tmp
                echo center_freq >>/opt/fw_set.tmp
                echo start_freq >>/opt/fw_set.tmp
                echo samp_rate >>/opt/fw_set.tmp
                echo start_mod >>/opt/fw_set.tmp
                echo rf_gain >>/opt/fw_set.tmp
                echo ppm >>/opt/fw_set.tmp
                fw_setenv -s /opt/fw_set.tmp
                rm /opt/fw_set.tmp
                echo "Done."
                flash_indication_off
        fi
}

echo "Changes saved here will take effect now and persist across reboots."
echo "If you (re)flash the PlutoSDR you will lose your settings."
if [ "$1" = "yes" ]; then
	yn=y
elif [ "$1" = "erase" ]; then
	erase_all
	exit
else
	read -p "Do you want to save the current settings to NVRAM? (y/n): " yn
fi
case $yn in
	[Yy]* ) 
	write_all
exit;;
esac
read -p "Do you want to erase all settings from NVRAM? (y/n): " yn2
case $yn2 in
	[Yy]* )
	erase_all
	exit;;
esac
