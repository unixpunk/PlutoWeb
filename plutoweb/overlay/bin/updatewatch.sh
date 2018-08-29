#!/bin/sh
# Don't need to run this directly, its called on boot if autoupdate=y

# Our job is to loop and check for the existence of update.tgz and update.tgz.md5sum
# If we find update.tgz, we'll assume its legit and use it.  This makes us very hackable.
# You could use any update.tgz and we will blindly extract it right over the top of /
# The update.tgz is simply the overlay folder zipped up.

# If we see an update.tgz.md5sum first, we'll use it to verify the upload
# Again, this screams, "HACK ME!".  But for real, hack it better.
# Source current settings
. /bin/readsettings.sh >/dev/null
flash_indication_on() {
        echo timer > /sys/class/leds/led0:green/trigger
        echo 40 > /sys/class/leds/led0:green/delay_off
        echo 40 > /sys/class/leds/led0:green/delay_on
}

flash_indication_off() {
        echo heartbeat > /sys/class/leds/led0:green/trigger
}

SLEEP=10s

while true
do
	sleep $SLEEP
if [ "$updatesrunning" = "y" ]; then
	sleep $SLEEP
else
	for file in /root/update.tgz
		do
	if [ -f $file.md5sum ]; then
		if diff -q $file.md5sum /root/.update.tgz.md5sum; then
                        echo "*** Auto-updates enabled - already up to date as $file ***" >>/etc/motd
                        rm -f $file $file.md5sum
                        updatesrunning=n
                        sed -i 's/updatesrunning=y/updatesrunning=n/' /root/plutoweb.conf
                else
		updatesrunning=y
		flash_indication_on
		sed -i 's/updatesrunning=n/updatesrunning=y/' /root/plutoweb.conf
		echo "Found $file.md5sum, checking for $file"
		sleep 3 
		if [ -f $file ]; then
			echo "Found $file"
			sleep 5
			if [ "$(md5sum -b $file | awk -F\\  '{ print $1 }')" = "$(cat $file.md5sum | awk -F\\  '{ print $1 }')" ]; then
				cd / && gzip -dc $file | tar -xvf - && echo "*** Auto-updates enabled and $file completed successfully with md5 ***" >>/etc/motd && echo "$file update complete!" && rm -f /root/plutoweb.conf && /bin/readsettings.sh >/dev/null
				rm -f $file $file.md5sum
				updatesrunning=n
				flash_indication_off
				sed -i 's/updatesrunning=y/updatesrunning=n/' /root/plutoweb.conf
			else
				echo "$file failed the md5sum."
				echo "*** Auto-updates enabled but $file failed the md5sum ***" >>/etc/motd
				rm -f $file $file.md5sum
				updatesrunning=n
				flash_indication_off
				sed -i 's/updatesrunning=y/updatesrunning=n/' /root/plutoweb.conf
			fi
		else
			echo "$file not found."
			rm -f $file $file.md5sum
			updatesrunning=n
			flash_indication_off
			sed -i 's/updatesrunning=y/updatesrunning=n/' /root/plutoweb.conf
		fi
		fi
	fi
	if [ -f $file ]; then
		updatesrunning=y
		flash_indication_on
		sed -i 's/updatesrunning=n/updatesrunning=y/' /root/plutoweb.conf
		echo "Found $file - Waiting 5 seconds before proceeding..."
		sleep 5
		cd / && gzip -dc $file | tar -xvf - && echo "*** Auto-updates enabled and $file completed successfully ***" >>/etc/motd && echo "$file update complete!" && rm -f /root/plutoweb.conf && /bin/readsettings.sh >/dev/null
		rm -f $file $file.md5sum
		updatesrunning=n
		flash_indication_off
		sed -i 's/updatesrunning=y/updatesrunning=n/' /root/plutoweb.conf
	fi
	done
fi
. /bin/readsettings.sh >/dev/null
done
