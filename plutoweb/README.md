# PlutoWeb

This is going to be an image with a web interface to control settings for openwebrx and which program to auto-start so you don't need to use ssh anymore.

Right now its the same as the openwebrx image with flask, dump1090 and SoapyRemote added to it and the ability to persist openwebrx settings as well as which program to auto-start at boot.  This way you don't need to re-flash just to auto-start a different program.

The new auto-reboot option is enabled by default and just uses a simple 'sleep 24h' and only takes effect after a reboot.

Find the corresponding README.md for each program in the respective legacy folder for more details.
