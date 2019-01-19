#!/bin/sh

. /bin/readsettings.sh >/dev/null

# Help
if [ $# = 0 ]; then
echo "
Usage: settings.sh <-r prog> <-R Hrs> <-u y|n> <-c HZ> <-s HZ> <-S SPS>
                   <-d DEMOD> <-g DB> <-p PPM> <-o num> <-E y|d> <-W y>

Make changes to the operations of the PlutoSDR.
General Options:
        -r      Program to run (openwebrx,dump1090,SoapyRemote,none) [$autostart]
        -R      Enable/Disable auto-reboot (In hours, 0 to disable) [$autoreboot]
                (Auto-reboot doesn't take effect now, use with -W y and reboot)
        -u      Enable/Disable auto-updates (y/n) [$autoupdate]
OpenWebRX Options:
        -c      Center frequency in Hz (70000000-6000000000) [$center_freq]
        -s      Starting frequency in Hz (70000000-6000000000) [$start_freq]
        -S      Sample rate in SPS (samples/sec) (65105-10000000) [$samp_rate]
        -d      Demodulation (nfm,am,lsb,usb,cw) [$start_mod]
        -g      RF gain in dB (0-73) [$rf_gain]
        -p      PPM [$ppm]
	-o	Override Pre-Set (0-4) [$openwebrx_override]
NVRAM Options:
        -E y|d  Erase all settings from NVRAM (d to reset to defaults too)
        -W y    Write changes to NVRAM for persistence"
exit
fi

# Read args from command line
RESTARTNOW=0
while [[ $# -gt 0 ]]; do
i="$1"
case $i in
	-E)
	if [ "$2" == "y" ]; then
	echo "Erase command issued, ignoring all other options!"
	/bin/savenow.sh erase
	exit
        elif [ "$2" == "d" ]; then
        echo "Erase and reset issued, ignoring all other options!"
        /bin/savenow.sh erase
	rm /root/plutoweb.conf
	/etc/init.d/S95autostart restart
	exit
	else
	echo "Invalid option: $2"
	exit 1
	fi
	shift
	shift;;
	-W)
	[ "$2" == "y" ] && WRITE=y || { echo "Bad option: $2"; exit 1; }
	shift
	shift;;
	-r)
	[ `echo $2 | grep -vE '\-\b'` ] && { sed -i "s/autostart=$autostart/autostart=$2/" /root/plutoweb.conf; autostart=$2; RESTARTNOW=1; } || { echo "Bad option: $2"; exit 1; }
	shift
	shift;;
	-R)
	[ `echo $2 | grep [0-9]` ] && { sed -i "s/autoreboot=$autoreboot/autoreboot=$2/" /root/plutoweb.conf; autoreboot=$2; } || { echo "Bad option: $2"; exit 1; }
        shift
        shift;;
	-u)
	[ `echo $2 | tr '[:upper:]' '[:lower:]' | grep -E 'y|n'` ] && { OPTION=`echo $2 | tr '[:upper:]' '[:lower:]'`; sed -i "s/autoupdate=$autoupdate/autoupdate=$OPTION/" /root/plutoweb.conf; autoreboot=$OPTION; } || { echo "Bad option: $2"; exit 1; }
	[ "$OPTION" = "y" ] && { /etc/init.d/S95autostart stop; /bin/sh /etc/init.d/S97autoupdate restart; /etc/init.d/S95autostart start; }
	[ "$OPTION" = "n" ] && /bin/sh /etc/init.d/S97autoupdate stop
        shift
        shift;;
	-c)
	[ "$2" -a "$2" -ge 70000000 -a "$2" -le 6000000000 ] && { sed -i "s/center_freq=$center_freq/center_freq=$2/" /root/plutoweb.conf; center_freq=$2; } || { echo "Bad option: $2"; exit 1; }
	[ "$autostart" = "openwebrx" ] && RESTARTNOW=1
        shift
        shift;;
        -s)
	[ "$2" -a "$2" -ge 70000000 -a "$2" -le 6000000000 ] && { sed -i "s/start_freq=$start_freq/start_freq=$2/" /root/plutoweb.conf; start_freq=$2; } || { echo "Bad option: $2"; exit 1; }
	[ "$autostart" = "openwebrx" ] && RESTARTNOW=1
        shift
        shift;;
        -S)
	[ "$2" -a "$2" -ge 65105 -a "$2" -le 10000000 ] && { sed -i "s/samp_rate=$samp_rate/samp_rate=$2/" /root/plutoweb.conf; samp_rate=$2; } || { echo "Bad option: $2"; exit 1; }
	[ "$autostart" = "openwebrx" ] && RESTARTNOW=1
        shift
        shift;;
        -d)
	[ `echo $2 | grep -vE '\-\b'` ] && { sed -i "s/$start_mod/$2/" /root/plutoweb.conf; start_mod=$2; } || { echo "Bad option: $2"; exit 1; }
	[ "$autostart" = "openwebrx" ] && RESTARTNOW=1
        shift
        shift;;
        -g)
	[ "$2" -a "$2" -ge 0 -a "$2" -le 73 ] && { sed -i "s/rf_gain=$rf_gain/rf_gain=$2/" /root/plutoweb.conf; rf_gain=$2; } || { echo "Bad option: $2"; exit 1; }
	[ "$autostart" = "openwebrx" ] && RESTARTNOW=1
        shift
        shift;;
        -p)
	[ `echo $2 | grep [0-9]` ] && { sed -i "s/ppm=$ppm/ppm=$2/" /root/plutoweb.conf; ppm=$2; } || { echo "Bad option: $2"; exit 1; }
	[ "$autostart" = "openwebrx" ] && RESTARTNOW=1
        shift
        shift;;
	-o)
	[ `echo $2 | grep [0-9]` ] && { sed -i "s/openwebrx_override=$openwebrx_override/openwebrx_override=$2/" /root/plutoweb.conf; openwebrx_override=$2; } || { echo "Bad option: $2"; exit 1; }
	[ "$autostart" = "openwebrx" ] && RESTARTNOW=1
	shift
	shift;;
	* )
	echo "Wrong answer...try again."
	exit;;
esac
done

# Re-run readsettings.sh to re-write settings.txt for PlutoWeb
. /bin/readsettings.sh >/dev/null

[ "$WRITE" = "y" ] && /bin/savenow.sh yes

echo "Done."
[ "$RESTARTNOW" = "1" ] && { echo "One or more changes require (re)starting the running program, doing now..."; /etc/init.d/S95autostart restart; }
