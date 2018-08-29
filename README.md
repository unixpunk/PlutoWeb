# PlutoWeb
*** This repo is huge, I don't suggest you clone it but rather grab the latest tagged release source code bundle.  <a href="https://github.com/unixpunk/PlutoWeb/releases/latest">https://github.com/unixpunk/PlutoWeb/releases/latest</a>

Use <a href="https://github.com/unixpunk/PlutoWeb/tree/master/plutoweb/images">latest plutoweb image</a> for most flexibility going forward.  All other single-program images moved to <a href="https://github.com/unixpunk/PlutoWeb/tree/master/legacy">legacy</a>.

Suggested method of flashing the FIRST TIME is dfu: uboot-env.dfu, boot.dfu, pluto.dfu

From then on you just need to flash the pluto.dfu or drop the pluto.frm in the USB mass storage device and eject, you don't need to reflash the others until the next plutosdr-fw update.

Suggested method of configuration is config.txt in the USB mass storage device.

If you don't want to flash these images to test, tar up the overlay folder from legacy/dump1090 or legacy/SoapyRemote, scp tarball root@pluto.local:./ then ssh root@pluto.local cd / && tar xf root/tarball && ls /bin.

Create new issues with suggestions for other software to package into images for the PlutoSDR and I'll see what I can do.

# Notice
The PlutoSDR was designed to be hacked...its a learning tool.  There is NO security on it.  It should NEVER be presented to the internet publicly.  Any remote access should be done via VPN or other secure tunnel like SSH.  This ESPECIALLY includes PlutoWeb itself!

# Features
PlutoWeb interface up and running thanks to ImDroided
<BR>PlutoWeb has the ability to select which program to auto-start at boot
<BR>SoapyRemote automatically allows both normal PlutoSDR via USB and remotely via OTG Ethernet/Wifi
<BR>OpenWebRX supports persistent settings - change them via USB config.txt file, via SSH settings.sh command or via the PlutoWeb interface

# Install
There are 2 ways to flash the PlutoSDR the first is:

First put the boot.frm on the mass storage and eject it, then wait. Once its done and back up, put the pluto.frm on the mass storage and eject it. Then it should boot, reboot once and be ready to go. If using USB, just enter the 192.168.2.1 IP into your browser.

The other way to flash the PlutoSDR is with the dfu utility. From the plutoweb/images directory run 

sudo dfu-util -a firmware.dfu -D pluto.dfu

If you have issues after and it wont come back up you will need to flash boot.dfu 

sudo dfu-util -a boot.dfu -D boot.dfu
