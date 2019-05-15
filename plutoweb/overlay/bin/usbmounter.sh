#!/bin/sh

# Don't run this manually, it runs automatically

# PlutoWeb Diskmounter and usb overlay worker
if [ -b /dev/sda1 ] && [ ! -d /usb ]; then
        mkdir /usb
        mount /dev/sda1 /usb
        if [ -d /usb/plutoweb/overlay ]; then
                cd /usb/plutoweb/overlay
                for i in `find *`; do
                        if [ -d $i ]; then
                                [ -d /$i ]||{ rm -rf /$i; mkdir /$i; }
                        else
                                rm -rf /$i
                                ln -s /usb/plutoweb/overlay/$i /$i
                        fi
                done
        fi
	# Launch autorun.sh script, if found
        [ -f /usb/plutoweb/autorun.sh ] && /bin/sh /usb/plutoweb/autorun.sh &
fi
