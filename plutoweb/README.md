# PlutoWeb

This is an image with a web interface to control settings for openwebrx and which program to auto-start so you don't need to use ssh anymore.

Once you flash your device, visit http://pluto.local/ regardless of USB or OTG Ethernet/WiFi.

Right now its the same as the openwebrx image with dump1090 and SoapyRemote added to it and the ability to persist openwebrx settings as well as which program to auto-start at boot.  This way you don't need to re-flash just to auto-start a different program.

The new auto-reboot option is enabled by default and just uses a simple 'sleep 24h' and only takes effect after a reboot.

Find the corresponding README.md for each program in the respective legacy folder for more details.

# settings.sh

> Usage: settings.sh <-i> <-r prog> <-R y|n> <-u y|n> <-c HZ> <-s HZ> <-S SPS>
>                    <-d DEMOD> <-g DB> <-p PPM> <-E> <-W>
>
> Make changes to the operations of the PlutoSDR.
> General Options:
>         -i      Interactive mode
>         -r      Program to run (openwebrx,dump1090,SoapyRemote,none) [$autostart]
>         -R      Enable/Disable 24hr auto-reboot (y/n) [$autoreboot]
>                 (Auto-reboot doesn't take effect now, use with -W and reboot)
>         -u      Enable/Disable auto-updates (y/n) [$autoupdate]
> OpenwebRx Options:
>         -c      Center frequency in Hz (70000000-6000000000) [$center_freq]
>         -s      Starting frequency in Hz (70000000-6000000000) [$start_freq]
>         -S      Sample rate in SPS (samples/sec) (65105-10000000) [$samp_rate]
>         -d      Demodulation (nfm,am,lsb,usb,cw) [$start_mod]
>         -g      RF gain in dB (0-89) [$rf_gain]
>         -p      PPM [$ppm]
> NVRAM Options:
>         -E      Erase all settings from NVRAM
>         -W      Write changes to NVRAM for persistence
