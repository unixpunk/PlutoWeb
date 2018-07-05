# PlutoWeb
Use plutoweb image for most flexibility going forward.  All other single-program images moved to legacy.

If you don't want to flash these images to test, tar up the overlay folder from legacy/dump1090 or legacy/SoapyRemote, scp tarball root@pluto.local:./ then ssh root@pluto.local cd / && tar xf root/tarball && ls /bin.

Create new issues with suggestions for other software to package into images for the PlutoSDR and I'll see what I can do.

# Notice
The PlutoSDR was designed to be hacked...its a learning tool.  There is NO security on it.  It should NEVER be presented to the internet publicly.  Any remote access should be done via VPN or other secure tunnel like SSH.  This ESPECIALLY includes PlutoWeb itself!

# Features
PlutoWeb interface up and running thanks to ImDroided
<BR>PlutoWeb has the ability to select which program to auto-start at boot
<BR>SoapyRemote automatically allows both normal PlutoSDR via USB and remotely via OTG Ethernet/Wifi
<BR>OpenWebRX supports persistent settings - change them via USB config.txt file, via SSH settings.sh command or via the PlutoWeb interface
