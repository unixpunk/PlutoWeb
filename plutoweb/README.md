# PlutoWeb

This is going to be an image with a web interface to control settings for openwebrx and which program to auto-start so you don't need to use ssh anymore.

Right now its the same as the openwebrx image with dump1090 and SoapyRemote added to it and the ability to persist openwebrx settings as well as which program to auto-start at boot.  This way you don't need to re-flash just to auto-start a different program.

The new auto-reboot option is enabled by default and just uses a simple 'sleep 24h' and only takes effect after a reboot.

Find the corresponding README.md for each program in the respective legacy folder for more details.

# settings.sh

Usage: settings.sh [-i] | <-r prog> <-R y|n> <-c HZ> <-s HZ> <-S SPS> <-d DEMOD>
			  <-g DB> <-p PPM> <-W>

Make temp changes to the operations of the PlutoSDR, at least until a reboot.

*Options omitted will revert to the defaults set at the top of readsettings.sh.

	-i	Interactive mode
	-r	Program to run (openwebrx,dump1090,SoapyRemote,none) [openwebrx]
	-R	Enable/Disable auto-reboot (y/n) [y]
		(Auto-reboot doesn't take effect now, use with -W and reboot)
	-c	Center frequency in Hz (70000000-6000000000) [460250000]
	-s	Starting frequency in Hz (70000000-6000000000) [460102200]
	-S	Sample rate in SPS (samples/sec) (65105-10000000) [600000]
	-d	Demodulation (nfm,am,lsb,usb,cw) [nfm]
	-g	RF gain in dB (0-89) [89]
	-p	PPM [0]
	-W	Write changes to NVRAM for persistence
