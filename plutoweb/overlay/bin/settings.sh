#!/bin/sh
# Pull defaults now
. /bin/readsettings.sh >/dev/null

# Help
if [ $# = 0 ]; then
echo "
Usage: settings.sh <-i> <-r prog> <-R y|n> <-u y|n> <-c HZ> <-s HZ> <-S SPS>
                   <-d DEMOD> <-g DB> <-p PPM> <-E> <-W>

Make changes to the operations of the PlutoSDR.
General Options:
        -i      Interactive mode
        -r      Program to run (openwebrx,dump1090,SoapyRemote,none) [$autostart]
        -R      Enable/Disable 24hr auto-reboot (y/n) [$autoreboot]
                (Auto-reboot doesn't take effect now, use with -W and reboot)
        -u      Enable/Disable auto-updates (y/n) [$autoupdate]
OpenwebRx Options:
        -c      Center frequency in Hz (70000000-6000000000) [$center_freq]
        -s      Starting frequency in Hz (70000000-6000000000) [$start_freq]
        -S      Sample rate in SPS (samples/sec) (65105-10000000) [$samp_rate]
        -d      Demodulation (nfm,am,lsb,usb,cw) [$start_mod]
        -g      RF gain in dB (0-89) [$rf_gain]
        -p      PPM [$ppm]
NVRAM Options:
        -E      Erase all settings from NVRAM
        -W      Write changes to NVRAM for persistence"
exit
fi

# Read args from command line
while [[ $# -gt 0 ]]; do
i="$1"
case $i in
	-E)
	echo "Erase command issued, ignoring all other options!"
	/bin/savenow.sh erase
	exit;;
	-W)
	WRITE=y
	shift;;
	-r)
	sed -i "s/$autostart/$2/" /root/temp-settings
	autostart=$2
	shift
	shift;;
	-R)
	sed -i "s/autoreboot=$autoreboot/autoreboot=$2/" /root/temp-settings
	autoreboot=$2
        shift
        shift;;
	-u)
	sed -i "s/autoupdate=$autoupdate/autoupdate=$2/" /root/temp-settings
	autoupdate=$2
        shift
        shift;;
	-c)
	sed -i "s/center_freq=$center_freq/center_freq=$2/" /root/temp-settings
	center_freq=$2
        shift
        shift;;
        -s)
	sed -i "s/start_freq=$start_freq/start_freq=$2/" /root/temp-settings
	start_freq=$2
        shift
        shift;;
        -S)
	sed -i "s/samp_rate=$samp_rate/samp_rate=$2/" /root/temp-settings
	samp_rate=$2
        shift
        shift;;
        -d)
	sed -i "s/$start_mod/$2/" /root/temp-settings
	start_mod=$2
        shift
        shift;;
        -g)
	sed -i "s/rf_gain=$rf_gain/rf_gain=$2/" /root/temp-settings
	rf_gain=$2
        shift
        shift;;
        -p)
	sed -i "s/ppm=$ppm/ppm=$2/" /root/temp-settings
	ppm=$2
        shift
        shift;;
        -i)
. /bin/readsettings.sh
echo "Changes take effect now and reset to previous on reboot unless -W is used."
echo "This also means that if auto-reboot is enabled, they will be reset then!"
read -p "Do you want to change these settings? (y/n): " yn
case $yn in
	[Yy]* ) 
echo "If you make a mistake, CTRL+C to exit and then start over."
read -p "Auto-start anything? (openwebrx,dump1090,SoapyRemote,none): [$autostart] " autostart_new
read -p "Enable auto-reboot every 24h? (y/n): [$autoreboot] " autoreboot_new
read -p "Enable automatic updates? (y/n): [$autoupdate] " autoupdate_new
read -p "Enter the new center frequency (70000000-6000000000): [$center_freq] " center_freq_new
read -p "Enter the new starting frequency (70000000-6000000000): [$start_freq] " start_freq_new
read -p "Enter the new sample rate (65105-10000000): [$samp_rate] " samp_rate_new
read -p "Enter the new starting demodulator (nfm,am,lsb,usb,cw): [$start_mod] " start_mod_new
read -p "Enter the new RF gain in dB (0-89): [$rf_gain] " rf_gain_new
read -p "Enter the new PPM adjustment: [$ppm] " ppm_new
echo "Writting settings to temp file..."
if [ -n "$autostart_new" ]; then
	sed -i "s/$autostart/$autostart_new/" /root/temp-settings
fi
if [ -n "$autoreboot_new" ]; then
	sed -i "s/autoreboot=$autoreboot/autoreboot=$autoreboot_new/" /root/temp-settings
fi
if [ -n "$autoupdate_new" ]; then
	sed -i "s/autoupdate=$autoupdate/autoupdate=$autoupdate_new/" /root/temp-settings
fi
if [ -n "$center_freq_new" ]; then
	sed -i "s/center_freq=$center_freq/center_freq=$center_freq_new/" /root/temp-settings
fi
if [ -n "$start_freq_new" ]; then
	sed -i "s/start_freq=$start_freq/start_freq=$start_freq_new/" /root/temp-settings
fi
if [ -n "$samp_rate_new" ]; then
	sed -i "s/samp_rate=$samp_rate/samp_rate=$samp_rate_new/" /root/temp-settings
fi
if [ -n "$start_mod_new" ]; then
	sed -i "s/$start_mod/$start_mod_new/" /root/temp-settings
fi
if [ -n "$rf_gain_new" ]; then
	sed -i "s/rf_gain=$rf_gain/rf_gain=$rf_gain_new/" /root/temp-settings
fi
if [ -n "$ppm_new" ]; then
	sed -i "s/ppm=$ppm/ppm=$ppm_new/" /root/temp-settings
fi
shift;;
	* )
exit;;
esac;;
	* )
	echo "Wrong answer...try again."
	exit;;
esac
done

if [ $WRITE = 'y' ]; then
	/bin/savenow.sh yes
fi

echo "Done.  Starting selected program now..."
/etc/init.d/S95autostart restart
exit
