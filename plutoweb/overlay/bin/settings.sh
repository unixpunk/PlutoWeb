#!/bin/sh
# Pull defaults now
. /bin/readsettings.sh >/dev/null

# Help
if [ $# = 0 ]; then
echo "
Usage: settings.sh [-i] | [-r prog] [-R y|n] [-c HZ] [-s HZ] [-S SPS] [-d DEMOD]
			  [-g DB] [-p PPM] [-W]

Make temp changes to the operations of the PlutoSDR, at least until a reboot.

*Options omitted will revert to the defaults set at the top of readsettings.sh.

	-i	Interactive mode
	-r	Program to run (openwebrx,dump1090,SoapyRemote,none) [$autostart_def]
	-R	Enable/Disable auto-reboot (y/n) [$autoreboot_def]
		(Auto-reboot doesn't take effect now, use with -W and reboot)
	-c	Center frequency in Hz (70000000-6000000000) [$center_freq_def]
	-s	Starting frequency in Hz (70000000-6000000000) [$start_freq_def]
	-S	Sample rate in SPS (samples/sec) (65105-10000000) [$samp_rate_def]
	-d	Demodulation (nfm,am,lsb,usb,cw) [$start_mod_def]
	-g	RF gain in dB (0-89) [$rf_gain_def]
	-p	PPM [$ppm_def]
	-W	Write changes to NVRAM for persistence"
exit
fi

# Start fresh
rm -f /root/temp-settings
touch /root/temp-settings
chmod +x /root/temp-settings

# Read args from command line
while [[ $# -gt 0 ]]; do
i="$1"
case $i in
	-r)
	autostart="$2"
	echo "export autostart=$autostart" >>/root/temp-settings
	shift
	shift
	;;
	-R)
	autoreboot="$2"
	echo "export autoreboot=$autoreboot" >>/root/temp-settings
        shift
        shift
        ;;
	-c)
	center_freq="$2"
	echo "export center_freq=$center_freq" >>/root/temp-settings
        shift
        shift
        ;;
        -s)
	start_freq="$2"
	echo "export start_freq=$start_freq" >>/root/temp-settings
        shift
        shift
        ;;
        -S)
	samp_rate="$2"
	echo "export samp_rate=$samp_rate" >>/root/temp-settings
        shift
        shift
        ;;
        -d)
	start_mod="$2"
	echo "export start_mod=$start_mod" >>/root/temp-settings
        shift
        shift
        ;;
        -g)
	rf_gain="$2"
	echo "export rf_gain=$rf_gain" >>/root/temp-settings
        shift
        shift
        ;;
        -p)
	ppm="$2"
	echo "export ppm=$ppm" >>/root/temp-settings
        shift
        shift
        ;;
        -i)
. /bin/readsettings.sh
echo "Changes take effect now and reset to previous on reboot unless -W is used."
echo "This also means that if auto-reboot is enabled, they will be reset then!"
read -p "Do you want to change these settings? (y/n): " yn
case $yn in
	[Yy]* ) 
echo "If you make a mistake, CTRL+C to exit and then start over."
read -p "Auto-start anything? (openwebrx,dump1090,SoapyRemote,none): [$autostart_def] " autostart
read -p "Enable auto-reboot every 24h? (y/n): [$autoreboot_def] " autoreboot
read -p "Enter the new center frequency (70000000-6000000000): [$center_freq_def] " center_freq
read -p "Enter the new starting frequency (70000000-6000000000): [$start_freq_def] " start_freq
read -p "Enter the new sample rate (65105-10000000): [$samp_rate_def] " samp_rate
read -p "Enter the new starting demodulator (nfm,am,lsb,usb,cw): [$start_mod_def] " start_mod
read -p "Enter the new RF gain in dB (0-89): [$rf_gain_def] " rf_gain
read -p "Enter the new PPM adjustment: [$ppm_def] " ppm
echo "Writting settings to temp file..."
echo "export autostart=$autostart" >>/root/temp-settings
echo "export autoreboot=$autoreboot" >>/root/temp-settings
echo "export center_freq=$center_freq" >>/root/temp-settings
echo "export start_freq=$start_freq" >>/root/temp-settings
echo "export samp_rate=$samp_rate" >>/root/temp-settings
echo "export start_mod=$start_mod" >>/root/temp-settings
echo "export rf_gain=$rf_gain" >>/root/temp-settings
echo "export ppm=$ppm" >>/root/temp-settings
shift;;
	* )
exit;;
esac
;;
	-W)
        /bin/savenow.sh y
        shift
        ;;
	* )
	echo "Wrong answer...try again."
	exit;;
esac
done
echo "Done.  Starting selected program now..."
/etc/init.d/S95autostart restart
